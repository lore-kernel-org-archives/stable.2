Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA930441624
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111241; cv=none; b=I1BGkMr3WcRRwHQo0EIUaBrnqUvROpnWpqbCztaIFv3sislWiOdnJNWUMQHo/9I+n5m/K3nBjMArPEYMY33E99Wbi5BuhOsfDP9vle/kfld7n6WJ42XfnaGZB5EToiI6ZkiEmXtCRJ2VojDuFS1xR0ZQPxatO9mvIhKY5MHkOFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111241; c=relaxed/simple;
	bh=5GXaQgvHU2r6ijFMCkzEQFt/N3yk5ZUkbo48U905HkE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dNcHtvJLfkir5H3IyAT38agE1EGOLOE+sExXDbCcsLinjspLjdpzrFCY6r3J5R2XA2oGTVlmgUoYnCyhx3zDQAxvvDlTFINjtitCjhHrxdsaQqX3dq8PAs6MnRw5WTybXjRa47GJppKz+RaQAIPzn9IAUchIsyw+Yz1GaFtOWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d84DND7X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d84DND7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7131F000E9;
	Wed, 15 Jul 2026 10:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784111239;
	bh=Q99KgC6bF2qTH5Kr8DhZpOmQAJlW4Iw/+YUEtegdzKs=;
	h=Subject:To:Cc:From:Date;
	b=d84DND7XhYg2Clg9kHLYrOfuIx94DkX7LZxA+iAcgc1yNP+2FQ9fiDQpI74NHe6vG
	 0PEAGmubCIxD7Q7vIiVk0Z/7yCU5TWXC4+5InjdVbwi8U0pofZh+3tTNot8LYjdDWq
	 KG3Xbc2F5pSjomt/gjNlV4lBPlKTU5ekHbRktpBk=
Subject: FAILED: patch "[PATCH] crypto: qat - fix restarting state leak on allocation failure" failed to apply to 6.6-stable tree
To: ahsan.atta@intel.com,giovanni.cabiddu@intel.com,herbert@gondor.apana.org.au,maksim.lukoshkov@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:22:51 +0200
Message-ID: <2026071551-small-whiff-1baa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7d3ed20f7e46b3e991936fedd7a28f3ff4aec8d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071551-small-whiff-1baa@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d3ed20f7e46b3e991936fedd7a28f3ff4aec8d2 Mon Sep 17 00:00:00 2001
From: Ahsan Atta <ahsan.atta@intel.com>
Date: Wed, 20 May 2026 13:33:00 +0100
Subject: [PATCH] crypto: qat - fix restarting state leak on allocation failure

In adf_dev_aer_schedule_reset(), ADF_STATUS_RESTARTING is set before
allocating reset_data. If the allocation fails, the function returns
-ENOMEM without queuing reset work, so nothing ever clears the bit.
This leaves the device permanently stuck in the restarting state,
causing all subsequent reset attempts to be silently skipped.

Fix this by using test_and_set_bit() to atomically claim the
RESTARTING state, preventing duplicate reset scheduling races under
concurrent fatal error reporting. If the subsequent allocation fails,
clear the bit to restore clean state so future reset attempts can
proceed.

Cc: stable@vger.kernel.org
Fixes: d8cba25d2c68 ("crypto: qat - Intel(R) QAT driver framework")
Signed-off-by: Ahsan Atta <ahsan.atta@intel.com>
Co-developed-by: Maksim Lukoshkov <maksim.lukoshkov@intel.com>
Signed-off-by: Maksim Lukoshkov <maksim.lukoshkov@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/intel/qat/qat_common/adf_aer.c b/drivers/crypto/intel/qat/qat_common/adf_aer.c
index af028488e660..3fc7d13e882c 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_aer.c
@@ -207,13 +207,14 @@ static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
 	struct adf_reset_dev_data *reset_data;
 
 	if (!adf_dev_started(accel_dev) ||
-	    test_bit(ADF_STATUS_RESTARTING, &accel_dev->status))
+	    test_and_set_bit(ADF_STATUS_RESTARTING, &accel_dev->status))
 		return 0;
 
-	set_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
 	reset_data = kzalloc_obj(*reset_data);
-	if (!reset_data)
+	if (!reset_data) {
+		clear_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
 		return -ENOMEM;
+	}
 	reset_data->accel_dev = accel_dev;
 	init_completion(&reset_data->compl);
 	reset_data->mode = mode;

