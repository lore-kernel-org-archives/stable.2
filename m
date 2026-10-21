Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.2.68.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584416;
	b=3ztZL+aTR5HvFrYmuVHNyQfp3sZvqurdnmPlNWLkzLW+HNwUG22Hu4NAWdLOUah41y85
	 hO7juT6OlH//wWixli5UCud7B8S7/GZIMZ3ObLrkzwK1LniiDjt39DVW/QtznC8aOqBfs
	 Mv/VM5YUx3AifrSVsB6rT/JfT5Gy8a9HIb7ilL3DlkXQ1Gc44T43aSSSuNcPjdXfTqlwL
	 r+n2fw4cgce525X/ndts9hndywfa0USPzMdn8oIe91ugy/6jpNxW4FlRkUy583R/4rMG+
	 GPO53/pNlIa7Bj1XOODAkJhRokgUInPGve7MBmUQOqnQ1kCzbAi1YHcrHpRB33kffrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584416;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:References;
	bh=QJXz6Gn2K1VN9nepLWRw3UZWWzN19sWrO7Tu6FlLAeI=;
	b=p9z8Nd0oxytPG7GtLC7uflRe58tZRzZNP8WPjDqBy9BBd++hjm2iFpgXGNrg+CJojF47
	 wrf2o012r4jK06wnTfzfeAsyM2K90K+D3KkU0hCafCoplin5cCNNetI+XH5YjrJ4/+9kJ
	 ROXm2ZmBvINHIWMA83pheSJyiDEp9WQfLx+1U8RvzYNo0cct7W4dJ2b8RwsHc0vVcNcCn
	 bAUicQqY839A5d3/EtCUWDBy8UJugW3FQDR5JU9ihmukPzQawkbVWyevOnQv6vQJzx3KS
	 4FN+XqNd6JIELzEiRiW4wKWj0k3DJ+6c8BGlP7SqBGXwM193Y53qwrESysBUaCpitzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=hlVKb17C;
	arc=none smtp.remote-ip=34.2.68.31
Received: from sonic.asd.mail.yahoo.com (sonic-usea4-0032.asd.mail.yahoo.com [34.2.68.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8738606A31F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8738606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=hlVKb17C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792584414; bh=QJXz6Gn2K1VN9nepLWRw3UZWWzN19sWrO7Tu6FlLAeI=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=hlVKb17CEX1iwg7IYfFB3E8muQEvY7ZDhOQ/SfqpdaKzwLNBNBlVj0sIYfrmjpQazlGnVGOD1sidyxRKYIEUs5k1rR8HNWMYvmim4fPdicgFMJAvMWocGTb+ng3CCpFPmnHAVktZ/SroAZaBysv8L8Hisfz4Yq04bF8cbv0SclwmYVkjgrJ/FjVN5KUcZCTY87wGQqYR7zHcll6UKyfiMDSdrxk4hnAUFPuBmO3e//rzV3DZ3hnp/ZNw9o3FpD36uMCi1/UPy/hnOkSfKBIt8nxHfcpd1ynLbfJJ8BN7SYXmb3lR464Th+ycuXyrXSbUZ8iTBORuaLHTgSJ7p7eDiw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792584414; bh=lJNUKOkvMAUjBOyRTgGYHWCGoY9FY7OJ8Fqrv8DVUSp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ndTPzLZpbHJXS2IxFnH2giBuc9g9CavAReL4RVoopFlOqSZoKlPw4Xqa2ZNX+fqQkKxQ5iBZ/PHph23aeHrimtJ8yZWuzW1/kB3MPRt36NPdV/hF5R2ohmDgUbwKrQ985hIBdXeYlqc9D13QaXF15owg9L5OPaRJXN5nznNcE86m0e7fNTwdPKvWb9ezjE6gIyOQlo805PAquEARfVD/Xo6wOlm7gvaPGgBKRCyyCrJdnmmYJyIi7intSJcfYhqFbPXNd4Ck9UCKDpVObrC2YXpqxj0jMgCvjukzpeS/0E94xwvEblRS3RWCXRPA4rIUYCnpqkKAzVoBZa0TcBqfnQ==
X-YMail-OSG: ExR99aEVM1kMAG6d2noY59moo6w6Htpi6tth1y7fipD9gkf5oDw5lXwLdiVjo5E
 dpEqNL.1ZvPcZNIW3w1TFQhEnWRJKYfQNktfE1HfwyO2bcUvOTbZLj9c8v0sJKZJqRixQx3UJEPZ
 SK0IOmJNzS6nyFVX2OXsMCeoR13T7iwIg9eTgvf_TZCnW4GouvzHpwuoxY8wpjmKAqc9kR7GcuvZ
 a2PMESFlC6howRTxzd44JS3ko.TJtg.I4OtPIN9Ce_t9cksFin6jwQ5_sSgfCVvpuCamRFMLNxb1
 1qGRjTHOMO_OcLR0j3Shh1XzF57nY8toCTY1JSg9Wa4jHGsXe2q4HQ8OKMJ19uuP2__3OYKPsgzT
 DMvO28fcLrmONJhblP5DmLJyNh04c16q3bzUJlnayOE1bVfE0aFJu5iH_B7oPSiJKWe9b3RdCdus
 y56.gv3k6NShEwxO_T3.142P.34ZuSZREuZpcgo9R4Rw6NL18fWlld8gSLE4VkEDjvzCvgWFk_QW
 zziY3gAwlp6.ygMY8K0oZQiOpkpJs_9jxiY80NAl44oM_6gVeMFhxc5eEwgLvb1LLaHKTWSeouAI
 GyKVJYf0znleEZAfqD7XddKKQ9A61vEBAe.sx_CfIKJuQt3CMB_AIKjBpsOxxjuBfooirCr5Ea_v
 zIZcNqJAurmIT7bDmVOmitAsM_4vScZwkZhOmLTEtunzEwSG9XwatZeko7QcUGCe56rKHb3Q44Gg
 8WplYrqOpwLogCNphzOBI3QnNEBvXEt5QrWTE2AhkhX4NJpSYGcgYs83SOFaBX_s.weQUEcBsGQj
 2eak.zSxmtD01zcl8wHDubv0h5aC9MRPlr0kOUdgYVkQYSkxOsd9mr0TkoWQ57Dy0g8rrFx2NTSi
 iH15Fyxbvbxd2TDx4iYQhb1C1Sdu0V3YEvkk7GwldjARImjU7EWOJxpM7Ib6aNlnA42pHINQt0n1
 lwGNCXsZRGX.32pov8BdpYNuIB8.Nub6roqSSsM9DqM3.b8H2SnuZKt_P_4WKH80WrtDR7I4HzWq
 8H8d2UYeJay50NXGR8CxPnw4lupyfz2blCx17atj0lvEMzcbK_giiAOGrPHe9YgwwTS6SIJpmtDp
 5evRyXx7d6rEGgnIoTkFUc3.e1cJeymh.VFMIJhJonGUIQLR6U8K88U56EMACxp5FxO_.Cpmk7sA
 ZnycQmmv7.QP3o2Bfy4eGTPvnlS7rh9oQ1WRBmsO119GRYvErWygrXWW5cPXYloc2h4Ko5A7ct.e
 8zIChEBSfx.faLi.pJ56e9hnN9O3OpNkGWYOaw7c7PP.cRDB9YMlAtC3jYDxHNuWzw6U.RAY0bbs
 fauaOqjgkx25BOz8jiA6yrvYU5rLFGCa84Ik3R4W4Z1ixes5ICg_YMm.QtCOnOqc_oeWeyN0ERqA
 c48D0FuBsCkaj4U1DmuvZyQh9raMAe6bJwWlp2iaF1Z_5nhPJGGBHt10Z4Gs65LVGQX33SueKGSs
 lnlFgVt.RYEw12Vqo2o5zsUYvrMNpGKyX7GfDsEDOCn2aj.IQB1vUprDSYo9istt7AZZ1gDk.qwo
 dDUCJcUOj8a3KXgEg4kx4ApeThYs3LncFX06PxEOQ0G9XMMQJf_DvXFnfIwNaEEoq9E_3zYkZHxg
 KD.I_IpLEKGshX1mPh_SReXdRp7nwqH1AtMpifq6ux0gdwrIeL2Cdil8KlvkM9OCnBoN4VBAb6sn
 33GE0FvtV3OLvLP1DZll4otBnc5w8R9ZOK7Zs7UeJ4eDMnTkFGsHliBOpFyLkmMFYVF1R_UVzmv8
 I1768qPpQX.5unCOgnC6gg1gDGrczWJDsinD8OZIKoMQSBrklV10ZbJ4MlPmjnS_1eZbYmeWzlEV
 sp4Na4ONhzFDkM2IMl6sEDqjPjbZxI6.MATHIy4zODSpZSuT_x_o5zRf_7K_vR4AMNeWHPFkUU34
 69jQ5qI9tGaeQq3vg3n7xSHdHumyNt3q0IU0FAXJOZbp4HsV8Cd5Z30FHW5kavUk8i2.k6zTyvhZ
 D5zj8BAQ7vaz0vOFaz7Rlrqzj7I1LqIqxjR1LAx.5
X-Sonic-MF: <stealth3m@yahoo.com>
X-Sonic-ID: a5e6f66d-5edb-4a9d-938d-21b10a912660
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-usea4-prod-sonicconsumer-svc-101 with HTTP; Wed, 21 Oct 2026 12:06:54 +0000
Received: from dip116.lsn.bf1.yahoo.com ([67.195.177.125])
          by hello (SMTP) with SMTP ID 4510d890358dd4fd8d57f3d1bca9c57b;
          Wed, 21 Oct 2026 12:06:53 +0000 (UTC)
From: Ext745 <stealth3m@yahoo.com>
To: linux-media@vger.kernel.org
Cc: isely@pobox.com,
	mchehab@kernel.org,
	hverkuil@kernel.org,
	ribalda@chromium.org,
	Ext745 <stealth3m@yahoo.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: pvrusb2: fix control enumeration with V4L2_CTRL_FLAG_NEXT_COMPOUND
Date: Wed, 21 Oct 2026 08:06:29 -0400
Message-ID: <20261021120629.1869411-1-stealth3m@yahoo.com>
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
Content-Transfer-Encoding: 8bit
References: <20261021120629.1869411-1-stealth3m.ref@yahoo.com>

Since pvrusb2 implements vidioc_query_ext_ctrl, applications that
enumerate controls with VIDIOC_QUERY_EXT_CTRL and
V4L2_CTRL_FLAG_NEXT_CTRL | V4L2_CTRL_FLAG_NEXT_COMPOUND (v4l2-ctl,
qv4l2) reach it with both flags set.  Only NEXT_CTRL is cleared before
the lookup, so the search starts above 0x40000000, finds nothing and
the enumeration ends at once.  v4l2-ctl then falls back to probing the
user-class IDs one by one: the MPEG encoder controls are not listed and
"v4l2-ctl -C" can't find them by name.

Mask the ID with V4L2_CTRL_ID_MASK like v4l2_query_ext_ctrl() does.
pvrusb2 has no compound controls, so NEXT_COMPOUND needs no other
handling.

Tested on an HVR-1950, kernel 7.0: v4l2-ctl -l on the video node lists
9 controls before, the full set including the MPEG controls after.

Fixes: 8b5ebc688054 ("media: pvrusb2: Convert queryctrl to query_ext_ctrl")
Cc: stable@vger.kernel.org
Assisted-by: Claude Opus 5.5
Signed-off-by: Ext745 <stealth3m@yahoo.com>
---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index 101b2e9fb..5c0117493 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -510,7 +510,7 @@ static int pvr2_query_ext_ctrl(struct file *file, void *priv,
 
 	if (vc->id & V4L2_CTRL_FLAG_NEXT_CTRL) {
 		cptr = pvr2_hdw_get_ctrl_nextv4l(
-				hdw, (vc->id & ~V4L2_CTRL_FLAG_NEXT_CTRL));
+				hdw, vc->id & V4L2_CTRL_ID_MASK);
 		if (cptr)
 			vc->id = pvr2_ctrl_get_v4lid(cptr);
 	} else {
-- 
2.53.0

