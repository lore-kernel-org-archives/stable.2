Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602925;
	b=uHqwNnF9Z3UsAOh0bvJXH5RZ1pt9rakJCiSK2RZQtDylUA6LMl+0OHYR6MF+HRmOIa4e
	 XsgdmcZp+3tTDs1OA+XpTuAeFMCqcC80TE0TIu2K8tnvhsZacnFem8y137xYE//jHUVT0
	 SvPM2LZSx/FOhHZ7gsOEbGrvo4+FTLTVam5cDsUMslQ2JIzLFsjeopWzZ/fG1pyiPD4dS
	 BR3RrYdiGKllupExdPFCH/ljtdYifsDEoLpQCEaY+7f7Qvp9ZgcNG5FT7YJywyDbsIpDO
	 H1ylONV0hP3MBfeG3D6HRVJ2XyfhzwjueFMZphjpmLpVQpQnjz/MWVTg/+NPco7olaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602925;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2TDj91z03txwkmIVqFzOrqDjA6DsMtxBHtoDBOqGXEM=;
	b=LjnMgm++7dEbdCnwZ2VN/jQ1R6iH1GAJq49vuQHHvPZU8/8Y7TuzCwc0ScMVsb32ieIg
	 WgphkCo+j9xgkWqZ9XI7vUm5GCK7rgKPAeDZ81x+ceEmrx/x8+qkw/1/aNHN35bMaDRO8
	 Tw5O2KEQKKh95EwN+siv0tpFJbGM6dhNySeBNyj7QCoyoumbqYWtJG50P1tHxeQZDucWR
	 blI++7wru3l9JGXqb4Qk+MNdf3lITCWRVhjn9kd25lceee/Pho0onFdDxgk2BqdVHw/q/
	 jrSE82QNbHdTQcVY+nNmS4viX42VxOUNWH20goO8HtMUrBwHpNUUIvbxz5XAJiNStrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="Qzqpe/xA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2631606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Qzqpe/xA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C954B1F000C0;
	Wed, 25 Nov 2026 10:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602925;
	bh=2TDj91z03txwkmIVqFzOrqDjA6DsMtxBHtoDBOqGXEM=;
	h=Subject:To:Cc:From:Date;
	b=Qzqpe/xAcZO+S8R1XQ2k8NibtjkLgtJJNcyTu/pMK3SIjYG/whReop9thqPVZCHVr
	 XG2QFoRTOv/8XXg2ZDYVTYlUdeXcgWYMz+t5XijUokB2Vo4DTqadBN245gw1J8Mis1
	 I0RCPeMiPEj9sUy8jzrYh9Pkss/TU1HRs1BgVjZs=
Subject: FAILED: patch "[PATCH] hwmon: (nct6775) Handle dual use registers" failed to apply to 5.10-stable tree
To: glance@ac2.se,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:18:10 +0100
Message-ID: <2026112510-freezable-rebalance-5328@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ca1abdd1a9b9ce51713a18c8905bf10579533c3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112510-freezable-rebalance-5328@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca1abdd1a9b9ce51713a18c8905bf10579533c3b Mon Sep 17 00:00:00 2001
From: Anton Lundin <glance@ac2.se>
Date: Mon, 9 Nov 2026 09:25:09 +0100
Subject: [PATCH] hwmon: (nct6775) Handle dual use registers

The REG_TARGET register has different meaning, depending on if pwm is in
thermal_cruise or speed_cruise.

This means we can't assume it's always word sized, so we need to handle
it differently depending on which mode we're in.

The code already does this, but the register was configured as word
sized for the speed_cruise mode, which would do the wrong thing in
thermal_cruise mode.

Fixes: 6c009501ff20 ("hwmon: (nct6775) Add support for NCT6102D/6106D")
Fixes: 29c7cb485b32 ("hwmon: (nct6775) Integrate new model nct6116")
Fixes: 437b3c2a4bdc ("hwmon: (nct6775) Add support for NCT6126D")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Lundin <glance@ac2.se>
Link: https://patch.msgid.link/20261109082511.851377-2-glance@ac2.se
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 6e97e4f08b90..3515a962adac 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -1188,15 +1188,13 @@ bool nct6775_reg_is_word_sized(struct nct6775_data *data, u16 reg)
 	case nct6106:
 		return reg == 0x20 || reg == 0x22 || reg == 0x24 ||
 		  (reg >= 0x59 && reg < 0x69 && (reg & 1)) ||
-		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4 ||
-		  reg == 0x111 || reg == 0x121 || reg == 0x131;
+		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4;
 	case nct6116:
 	case nct6126:
 		return reg == 0x20 || reg == 0x22 || reg == 0x24 ||
 		  reg == 0x26 || reg == 0x28 || reg == 0x59 || reg == 0x5b ||
 		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4 || reg == 0xe6 ||
-		  reg == 0xe8 || reg == 0x111 || reg == 0x121 || reg == 0x131 ||
-		  reg == 0x191 || reg == 0x1a1;
+		  reg == 0xe8;
 	case nct6775:
 		return (((reg & 0xff00) == 0x100 ||
 		    (reg & 0xff00) == 0x200) &&

