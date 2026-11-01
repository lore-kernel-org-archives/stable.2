Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793496380;
	b=Bx/CrUlM+nWcMHHh01lRg6wsAc+WpmWAi9xFmSQMf+fUn741aq5Pc+ASr+Yizb9gXZwt
	 Bu092X8Ba3aEzfO9H/OrucfobyW9BXa0EYF14UbJdJWRZ8bqyFr3mLC2ibE1Wu42doVcm
	 SQs1oPsH6BcxhAU1F+dlbyFzACzN7yhIcuxDjdpwc3e57IGnw+56uTprNmdIbhwlbJ8/1
	 arqekx/DLAZSL9rCAiQeWvqty53TJX1CN7VkDLKbey9c7lDLUVttos+LSmajKkxDv1VWl
	 2CuX1gthbpYdQahHo5Nucd+sgxzZQvwba1+XlXv9A24jSMGH3pUH/IbZFlEry7dfF3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YIO/wuqnNRfPuoyQxCQ5Pvo+F5MRblOAdwgMq3xL4Lc=;
	b=F5xuOWUad8a9BOXOd5y3r8Npk5KaZ2cX5JStFnNAuuO+wktcC5hl49mabyjnvIFFtz2d
	 41nGhfs8nV1eI2FlWkfm6tQyAO3DIBdhnS4PcgMGHjGFXe543L7+2BCmj0FDL2RcYTLYA
	 uBK4qczzWsTlymsH4Z53UvPLbhjzY78y8dAEcVcf+uGK8kISLIMw/HGjEnwquPjzDYc/v
	 roe8ED7r0DqADGRvVnu5IjbKUgYZXDlNH18mFwli7pbvr1qqeD/nOZn9+nlj5R8v5TroX
	 Odj6rpp7NE+xyYZWHWheCxkOaLE59DdK1xh0m/ftgihB6LhxD8V54r9Lg6gAMhF+qvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZdzdKzz;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8410606A31D
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 01:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8410606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NZdzdKzz
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7c03744ef27so600409137.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 18:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793496379; x=1794101179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YIO/wuqnNRfPuoyQxCQ5Pvo+F5MRblOAdwgMq3xL4Lc=;
        b=NZdzdKzzFe070I/A4X0Fc37wFboISxd+dXeprLXL93hPsdzyrxnOaSYC/oKSwdpRBm
         lpn3m96r40JJqJzs89RLwlSccm9pWzFYp/Emofr0XL3WgAQ7UlSHV8dfA3KNYpWvX+lK
         wgkjgGR/8jfPobWkC/VnLPZHmkOS7JyCD9b6AoIPE87MXiquya17jytSlyBh0lS9Ii1z
         6eLpAa4nDORZ9DmL5U0qabmWsvJ8r2n242dLo565TSVzWBbaeWkXZ5M9gghEhvX8eIpS
         UsRLUsJh2hAj96GuQY74YSZnzPsQcWumuMikix9nioU3RlzSJdu7NLcjsL+Pz7CBOjdj
         7fEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793496379; x=1794101179;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YIO/wuqnNRfPuoyQxCQ5Pvo+F5MRblOAdwgMq3xL4Lc=;
        b=nzuCfNQGii1jEXAksMr5yDM/CNAuF9JPiZDmIqgVWZVsVsgB13RH8X4dYRcSBDDK46
         iazUH1Ac9Oj0Hmd1LVBf9cwtkhedeQtRquku1eKtv6B0gkAMGb6cacAkc9DaGfBD3C8d
         ZJv//M8fUm4WHbDxH4BLBH2CrWx7gYHBVu3figEnbkzOmDGeehiuszSSGEDNa7sAiwft
         ZWZUIPHC4msORmwoqYg25iJeNgDKKT0NG8j0/Vq0oiyS8j4yUyvHogDtS9HIB663Vxf5
         mdUKeNGgQa6l+QHi557zWP7P+njCa5emZzKqzCHbwR05hJvdGZSfqhoMq1YRwAUUAzT3
         eXqQ==
X-Forwarded-Encrypted: i=1; AKwUvByzk8b5G5JLerOQjLoX6SrTWJkj5jm2/i4oYlIZdPSdDPP3szen/zr5uCcxaIaSTARfN9lNsms=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrxDlM7qw1n/p4ByWS1HJubbwN2K+wGFSVXjXaSN8UFL2vIyZl
	R5fw71xeEK0BR+iRs4x1bw9DPQjqRQHovrkmXVM0ncwEq/825qoGA/w3
X-Gm-Gg: AYBFou3ze4972NdEuqej1Ok8rstgt7LidPwS8A01ARuwGjil8OpcNplZr4+jTFww9Tu
	LxaBP24MyU3id/zjFw4LgLOvAnGWvPynD19y9ZYoroT/QOITfczIcf+X2qj4xccHVeHGArarXX1
	AXY9jxUj6ggwMk8nvzqkWK8HwOCMcEljX4DCHi4RqMDgQjufcKiYZ7SjbNj3gNs35EmXA2AuxMp
	xO3PJUiBJehVMNv7ZlMoWLCAl0+UXdJr9uaphA6HWPUffgUG6ium/ABKyAS5Pfrc/+RjxaNicCs
	vW2DdKVGaBS89zseuBHsiIfe7voPpdh5ZkwfD/s8llXJaIF6yM1GpoTplzM3CvHr42Ibdzq8LHs
	l8OxHgNbYchE6cFNjl7yaUBuzjI4M/R7SoZFigOPyzjPD/rOlguAt71uSDaHfQxW8UrvnUyGDaH
	VQt8VzLELltURPw13bdfF/AyqDWLIDyzU2SQ3noAVGwLuDol6dAcgP2oX3GMs8QPZzN6dEVlBTd
	QvAD8IC6qwuUlVMEreEQvJ/OeiSg4MVDg13CNsby3ptoVkrtebcJzVkgNWj8uoJx7GiSZtRY4Cb
	3D0YrLj/xYMq8IWtuJaYAbYvhp5w2WkmJRweyQd2e8RzMy+KqKLBmDZ8GPYQ+HYJWNFFy92Drw=
	=
X-Received: by 2002:a05:6102:3309:b0:785:c39b:6a1 with SMTP id ada2fe7eead31-7d072636f57mr2626543137.6.1793496378542;
        Sat, 31 Oct 2026 18:26:18 -0700 (PDT)
Received: from nb-x1-03 ([181.120.144.175])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07754c1c6sm7089367137.3.2026.10.31.18.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 18:26:18 -0700 (PDT)
Sender: Ciro Iriarte <ciro.iriarte@gmail.com>
From: Ciro Iriarte <ciro.iriarte+software@gmail.com>
To: "Martin K. Petersen" <mkp@kernel.org>
Cc: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] scsi: target: core: Parse APTPL res_type and res_scope as hex
Date: Sat, 31 Oct 2026 22:21:39 -0300
Message-ID: <ea903e6c-09b5-4a11-80e8-6e1387f39ef5@gmail.com>
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

core_scsi3_update_aptpl_buf() saves the reservation holder's type and
scope to the APTPL metadata file as zero-padded hex ("res_type=%02x",
"res_scope=%02x"), but target_pr_res_aptpl_metadata_store() reads them
back with "%d" tokens and match_int(), which parse with base 0. A
leading zero selects octal, so match_token() parses only the "0" of
"res_type=08", the trailing "8" makes the token not match, and the field
is ignored as unknown. An Exclusive Access - All Registrants holder
(type 0x8) is left with type 0 and the write fails with -EINVAL and

  Illegal PR type: 0x00 for reservation holder

Userspace that restores APTPL state by writing the saved records back
to pr/res_aptpl_metadata (rtslib-fb does this when it recreates a
storage object) therefore loses every type 8 reservation across a
target restart, and with rtslib the storage object creation fails. The
other valid types (1, 3, 5, 6, 7) and scope 0 only work because their
octal and decimal values coincide.

Keep the on-disk format and parse both fields as hex. The valid type
and scope values have the same hex and decimal representation, so
records written in decimal by hand keep working.

Fixes: c66ac9db8d4a ("[SCSI] target: Add LIO target core v4.0.0-rc6")
Cc: stable@vger.kernel.org
Signed-off-by: Ciro Iriarte <ciro.iriarte+software@gmail.com>
---
 drivers/target/target_core_configfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 2b19a9560..a45bb3d56 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -2126,8 +2126,8 @@ static match_table_t tokens = {
 	{Opt_initiator_sid, "initiator_sid=%s"},
 	{Opt_sa_res_key, "sa_res_key=%s"},
 	{Opt_res_holder, "res_holder=%d"},
-	{Opt_res_type, "res_type=%d"},
-	{Opt_res_scope, "res_scope=%d"},
+	{Opt_res_type, "res_type=%x"},
+	{Opt_res_scope, "res_scope=%x"},
 	{Opt_res_all_tg_pt, "res_all_tg_pt=%d"},
 	{Opt_mapped_lun, "mapped_lun=%u"},
 	{Opt_target_fabric, "target_fabric=%s"},
@@ -2229,13 +2229,13 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
 			res_holder = arg;
 			break;
 		case Opt_res_type:
-			ret = match_int(args, &arg);
+			ret = match_hex(args, &arg);
 			if (ret)
 				goto out;
 			type = (u8)arg;
 			break;
 		case Opt_res_scope:
-			ret = match_int(args, &arg);
+			ret = match_hex(args, &arg);
 			if (ret)
 				goto out;
 			break;
-- 
2.55.0

