Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048209;
	b=4fbHl4yldjUSHvvFYpDakSlcYoAWYeMc2hzOwQ2vBdJzIVZRuoadeJaRqQ/xEHCbnULN
	 En45eUj6Jzr0nJa+ladBsTBPWxnH0Gu7hzZpudAr7Xvp3ErrtECwP6E1xun6ZKQNmWGTg
	 0OqW+qbIWybTpsz5LCqSjjoMs2UksTQdHEnM3fPbpVGtAnASoh1J2SyoIWVB3yE7Cm2rc
	 adyUzQjJ59fYeIlx3hgCzH3OrxhfJutRuuO1YoFi2U7UI0PMu2yBeflnqEyAeyKD6Qr5i
	 cTTtYYoNpDuTvhm0dRKPwRG9BW9c1QZkIDMMWRXxuFHawQ079cfMrqt6xUC9uxXKYmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048209;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=61nOh2ZgPk8wC32znG58O8UBg2uyz1lz8C4uCHiuJSI=;
	b=tTuoIJflHKyUyeaxJHDF5/nwiD4eOXAz7RZAvGdQTkQcwCEWvhjwA8bLMLxJYcxP7qGD
	 o3UNqkloe1luoSrcZzs6EkFHTXe5c1d+eDX404mbm3wNRxlyA8vuzZXGQjP9uQ8D80Ssi
	 jtj87V1QUJErjJ0luLMyWlQT7iTYEc1Re5gcy/2wB5aAspkDu96VL/hpEKw0cmrKV/m//
	 DF05At5rkuwdRkLQSElKCjpUCFOI3waYaG1boSHIPezUO2/sc36bOkKJ4X/xeqGtmOcJK
	 SaoBPqCsyae3TGEr+OSjMR5gYoEVvteF7Kf6jhRWzAvwnBV+fKXPLzz7lW6fo3WLopw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZ7USnGh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZ7USnGh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB591F0089F;
	Sat,  7 Nov 2026 10:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048209;
	bh=61nOh2ZgPk8wC32znG58O8UBg2uyz1lz8C4uCHiuJSI=;
	h=From:To:Cc:Subject:Date;
	b=BZ7USnGh6rR2tsUkMZNXmN8foX0Vf85QiZtsJUuxv+AjFMP/xdtDQMBntWZFx2D9Y
	 qLZNX9PY/WEfFhXxVrlYqSqJBUgaxWmeN8UUJed27hZ+hnb8HE1CTG53cSAhwNcyGs
	 ZzchpouggnEf1c9zOjumkPx0KHDfG81gADV7DIC83o2xA73gB6/Zxrwd+Wfs0eZf1c
	 1xWC8G7MQPuTS0KabwMemqLONpovlKi4OdXBTFWr/8isS3NsUlSglnE778d5F+LB+t
	 94nYBEPw8mDn85459OgVS2eMLGr2XIOSOjNy8u2iLKFzgtATHSyJW7EMabMVWSUgog
	 Rul228xUcFddw==
From: Sasha Levin <sashal@kernel.org>
To: ssrish@linux.ibm.com,
	rnsastry@linux.ibm.com,
	maddy@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] pseries/plpks: fix error handling in plpks_read_var()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:27 -0500
Message-ID: <20261107054327-failed-6.1-d52a1659cb17@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d52a1659cb1718f93166ab8dd8621237e564a1c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054327-failed-6.1-d52a1659cb17@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d52a1659cb1718f93166ab8dd8621237e564a1c4 Mon Sep 17 00:00:00 2001
From: Srish Srinivasan <ssrish@linux.ibm.com>
Date: Wed, 23 Sep 2026 23:58:05 +0530
Subject: [PATCH] pseries/plpks: fix error handling in plpks_read_var()

When a PLPKS variable is initialized without a policy and used to read an
object with the PLPKS_WRAPPINGKEY policy set, the hypervisor returns
H_AUTHORITY along with the object's policy. However, plpks_read_var()
currently treats this the same as any other H_AUTHORITY failure and returns
an error without propagating the policy information to the caller.

Distinguish this case from other H_AUTHORITY failures and propagate the
returned policy to the caller while preserving the authorization error.
Remove the explicit assignment of zero to rc on H_SUCCESS, as it is
redundant.

Also validate the PLPKS variable pointer before dereferencing it.

Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
Cc: stable@vger.kernel.org # 6.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260923182816.151451-2-ssrish@linux.ibm.com
---
 arch/powerpc/platforms/pseries/plpks.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 23e4e2a922fcf..7e56b3dcacbc7 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -822,6 +822,9 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 	u8 *output;
 	int rc;
 
+	if (!var)
+		return -EINVAL;
+
 	if (var->namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
@@ -856,22 +859,21 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 				 virt_to_phys(var->name), var->namelen, virt_to_phys(output),
 				 maxobjsize);
 
-
 	if (rc != H_SUCCESS) {
 		rc = pseries_status_to_err(rc);
-		goto out_free_output;
+		if (rc != -EPERM || !retbuf[1])
+			goto out_free_output;
+		goto out_copy_policy;
 	}
 
 	if (!var->data || var->datalen > retbuf[0])
 		var->datalen = retbuf[0];
 
-	var->policy = retbuf[1];
-
 	if (var->data)
 		memcpy(var->data, output, var->datalen);
 
-	rc = 0;
-
+out_copy_policy:
+	var->policy = retbuf[1];
 out_free_output:
 	kfree(output);
 out_free_label:
-- 
2.53.0




