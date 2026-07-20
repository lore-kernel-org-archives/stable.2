Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FEE2C234E
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560780; cv=none; b=c8BDVg/IGgCnL2G/GW/LZShsqx+ovILEfY03BvufGdzBN47dh2ywpGIFc99vOFiL+gB+AD7nhZ+jjkj7mnd13taQF1NRrO8eS1kGsNhnT8oGzBdR0iDzk9Si2XGOa5pjbfkD+jDv+G96NYNQ1ln5C4cmR0+2WPosDG2tHsTaO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560780; c=relaxed/simple;
	bh=Ls1o7RIvcrIi1aCA99qWuPMxIaVeCkNoMQ8QRdunR/s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CD7QoR+/st1sGwkXf2TFNCOcnxpLHWYHVaaWxsXyN0zEGB/ueVWyI4NAPbcr51BveFmP+x0UqvFro71n3gMS9m2vtur49Qae799s/1NBnuz8HgUGPy1qpNNpAzB3XhD5qJneq4CeQC6ceCuYqI3mOeKLP12K/wOPfimti4EACF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZZcAk0DF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZZcAk0DF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB771F000E9;
	Mon, 20 Jul 2026 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560779;
	bh=V/Hq8kDX537DoOaX4juahUlK/L0WxYRPNmg4IDlF6/s=;
	h=Subject:To:Cc:From:Date;
	b=ZZcAk0DFFYk2olQ7pzBYjUIPAz5/6wMv55UxzuihcLKGeiN4wBLjMhYGJe/EcPS63
	 7TImEESCTM1G6AJNO9GA+aCqZYH9gyo6LlVAfUd3xDvQl7p62VtCYOhovHP26BDAa7
	 wDU2EGzfZ21T1YH85wx0oMMDVLP4i5a+p7/vHdkc=
Subject: FAILED: patch "[PATCH] dm-verity: avoid double increment of &use_bh_wq_enabled" failed to apply to 6.1-stable tree
To: mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:19:20 +0200
Message-ID: <2026072020-agent-amiss-f82c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 72e9ec2fe32b00994f41719cf77423fca67d48b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072020-agent-amiss-f82c@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72e9ec2fe32b00994f41719cf77423fca67d48b2 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 9 Jul 2026 21:33:16 +0200
Subject: [PATCH] dm-verity: avoid double increment of &use_bh_wq_enabled

verity_parse_opt_args is called twice, first with the only_modifier_opts,
first with only_modifier_opts == true and then with only_modifier_opts ==
false. Thus, the static branch &use_bh_wq_enabled was incremented twice
and the destructor verity_dtr would only decrement it once.

Fix tihs bug by only incrementing it on the first call, on the second
call, when v->use_bh_wq is true, do nothing.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Cc: stable@vger.kernel.org
Fixes: df326e7a0699 ("dm verity: allow optional args to alter primary args handling")

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 9a9847f94c46..adfda1fdab6a 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1262,6 +1262,8 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
 			continue;
 
 		} else if (!strcasecmp(arg_name, DM_VERITY_OPT_TASKLET_VERIFY)) {
+			if (v->use_bh_wq)
+				continue;
 			v->use_bh_wq = true;
 			static_branch_inc(&use_bh_wq_enabled);
 			continue;

