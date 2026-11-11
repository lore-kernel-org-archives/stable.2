Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415940;
	b=nKd19eyBywNY7uHFK5n9f+FQEo5Sgu8hxSvJV5kgrDGYPGtD41Ysvkh/awjJoswZ6sGz
	 bBjZGLe4M6fae/+3jdmTL8Ou0T/SKSZvr94D1lURXgKM8TYOef5KO/xxvKuYkerx77fO7
	 gGfFFlCq+BbBD6lY16ckQuBLhP9r7ua8m37Vf83RdQHgQsCs0WwvS4sVlNHXm2Bm1goH8
	 +LS3vFVw1PXHoGcYH2CvBCVD0qi/IzKANYJTyBne4A510g+EzNjzVKRdWmwlhlz7Q1R4g
	 oGndfvP3QwLeNYSfpQUB/Iz5ThzAm1vhg5bG8CZ7bkrG3WyT/+RNDroEKObYRred1OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415940;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kSoItRJuQfRRs61lLc6FuuYgJFA4KKiLvZnEmyEjooE=;
	b=5idOlBYjzS8A/DKwXHXwHBMqYNOM2/T6qgelz/f0Cp8ikSTOhhG6aj5nd7jbNNz9lajE
	 UOjVI7lBi9Sa98mv4MlLPqMZi8qYIKb1ktPAuAwmyYGfFuW4DY6EdKkECxEOOrS/0kwSl
	 /NTivMpVP2n+gMisyz71qo28A1BvjgyUSZknIY1hztIcwtcPdnEv4AYX4I506BQNTs4yN
	 xB9rlBiN+OnxaJ08C/r+x8/X64comfTMvYDaeYU+kC4pFzBK7tidCJrlrYuhgA81L+75r
	 A1mQLs1EUGHCpgsVPerUBcukvoTFHmqRDPaYvh/U/Y0Z4NnoMyO1EuTsV9Cpb+hnQpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvsDiMk+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90631606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvsDiMk+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6DB1F00A06;
	Wed, 11 Nov 2026 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415940;
	bh=kSoItRJuQfRRs61lLc6FuuYgJFA4KKiLvZnEmyEjooE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MvsDiMk+vISVGsva2cpL2havjjblgcG1pE1zVyhgmD+8sq5gO18PdqLak/tm7z8TL
	 xO8or14NkhVVTlu3uHvapNYqNt577eI3/EN5ts9fT/6O0iDHI27RZvxrbTEfoacRae
	 xL11fQ2MEJ0vaTu5RoQBzPMffpw03LSahXtWFBh6D9dUQ7aS/TiuLvpTZkZcrPZqu0
	 1dH8OB4eQIQU67UTZeCNkH0r8vnZw7II8Mp5TqekyRQ8U0TbF+SQifA0hNlDLN6HxX
	 0tKXWsCKkDYj2d10NvCBl5ZTSxwFpUjDse1clVPrggHAswXF2jCVjMZWE5byalqj9r
	 M6lBOOiTuCuww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srish Srinivasan <ssrish@linux.ibm.com>,
	R Nageswara Sastry <rnsastry@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] pseries/plpks: fix error handling in plpks_read_var()
Date: Wed, 11 Nov 2026 11:52:17 -0500
Message-ID: <20261111165210.3351833-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111165210.3351833-1-sashal@kernel.org>
References: <20261107054327-failed-6.1-d52a1659cb17@kernel.org>
 <20261111165210.3351833-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srish Srinivasan <ssrish@linux.ibm.com>

[ Upstream commit d52a1659cb1718f93166ab8dd8621237e564a1c4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/plpks.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index b66a980478fec..b15e841b19791 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -489,6 +489,9 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 	u8 *output;
 	int rc;
 
+	if (!var)
+		return -EINVAL;
+
 	if (var->namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
@@ -520,24 +523,23 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 				 virt_to_phys(var->name), var->namelen, virt_to_phys(output),
 				 maxobjsize);
 
-
 	if (rc != H_SUCCESS) {
 		pr_err("Failed to read variable %s for component %s with error %d\n",
 		       var->name, var->component, rc);
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
 	kfree_sensitive(output);
 out_free_label:
-- 
2.53.0

