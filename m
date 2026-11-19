Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081889;
	b=KM1LwR7nX5zLzIze9x1v4ChC932Bapg+CWMGiaCQyAcJ9V+jP6HgTh7tKsVQrvhcWATd
	 9zqnLJtTsWW3mgkgY5Uf8GOCtsOQXcpHex/ARb/8B5cCRt4k7+ZSCcf9LxMs0HzzMy131
	 inwAkrEKQziMbTULF+LztTTRzt1hc0BJy7YX/sEA3wI8cYkXgwdhfxNRKb8l8ExjzW6wn
	 ls7fnB+9Tjg94Lq5l7EA1WcY6rleijGxgZbFNuhIjMggyNsXxzLbPsVRw3Sv2EyeAGUPg
	 tU2tKPAQ2q9+09JsjmH5dlLtE+6eclvXcsnUgq8ZDOwU+tJ5VCOna27I9/+xxALqdUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=lzDU21F2EHLB7rOP/VYbDq+2X8MhT5hkKO20Bmq0VFU=;
	b=DoBcXbKXy7RdSGYGEOnX+gIe2wEuRl/W725j+u8Jcxg/eZabt4Sm5ezvwuqygzNSymp1
	 cKsOnU137Vp71XTFRTckSFAhhLvkzDijQkcbHB/qo8RAXF364BTTwUlar26hgV/6zBL9l
	 UKfSkrv1PuDalIHYb5DQjL886SzDoD6f/Y945pOXF+3U88RjZAze3bCouyj9YIDQHsXH1
	 uW18qfqvl/gT8m7Jgx/0cH4Sy5OOUltGjZ8l6QFVP2uD5xiQtnJZaq7xW2tyuQcp140dz
	 xbsSSXqCEcttPVAnNXPy/lIgNRuvNTFvuM4dYgyl2zp1Zrn5Or+LiDfWOMCjHqk0Slw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=tuT5UoBr;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF6E60A2625
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AF6E60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=tuT5UoBr
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c5124dc427dso126063166b.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 01:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1795081887; x=1795686687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lzDU21F2EHLB7rOP/VYbDq+2X8MhT5hkKO20Bmq0VFU=;
        b=tuT5UoBraM7XADG/B+vWLbNmwJGNEmNaCzbPRSq/rt3g6pOqHbBtGLQv7O344swf8i
         m9hEtpaZN/9MqKHcbuqaHH+hQQBks9WlJ05E9e1BVwdTevrDWHUPWlhb745nVNmcB+rS
         s1Sq6aCJuYJalnpoTCtudQN169ZRKGb0qZxA0nVlyFM4U7/CIAs90tc1t2Cl6m2JvZZH
         SdmCLLRacQFAdhsKvKg9eYO4XPPJ8F7s+1Xwr9FAgLA9VlQHByko7ZkVKzBO1Bsz3jLc
         4zrq6pbkt6NZMaeUHgxPtbFH2eYoQ0qt3/Ax3C6DAaxiO/EovBzzfgu0f/zy5QMYy4Iz
         nWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081887; x=1795686687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lzDU21F2EHLB7rOP/VYbDq+2X8MhT5hkKO20Bmq0VFU=;
        b=FnolkPsEMYqplUDp1wZhzdZ+vlLZqPgBRtYWZF1wumPkN6Gntew21JC+mcJHkiTELj
         6xD/AYELfFPBL+BFKOh91lbm45uQM98LV3/VPl6dby2c9qcbd4IGueMD/PIv6GG6DN1N
         OyraaOJwGkbW5R+J86kdvh/1bySMzmEr9Rn4aHaoEyAmy6JRPM33JACk/3Ro7wXlF0PY
         hl1filOgUoTSqHssPa5LbfB+Re1IrnuzzyclY2YToPhN39Bl1sc1YXH1NeZpjTxMbPS5
         MsnZDC5TMWfSqRLyCc8hxybAhhg5+iMvp1CboBTSnV02RgE1GLEejuzCFH8SATN6dHuZ
         ok0w==
X-Forwarded-Encrypted: i=1; AL+hErGjQAcHGRlj4JV64NOvKMG2df/NJ8odstpfrVP9VVvSSsk9AFtCA7mUG8iFVHOQaCheRoBBIq0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9u+U/BgbvkWElmAzUzE185uDdzVoDqLdrVLR7SpGjY5+OgIxwh
	2GVxgASNrxlMlT7iYoqtr4uYZfTGobnbSUviNM7TcgQ7NcGamts8cpzVhVsH0Er/844=
X-Gm-Gg: AYBFou37AkjodN3b6Kb5gXEAYLCemkDY3JG/LeXMjkGHGl39q/gPUQt7ip3LzSBvk7E
	i179MFvu1vUeXmU63JPh6EAHko0miIb3sOY97f8E0JBEjuOxvlNd8xqoCrjHxpjaDAS6txXUR83
	k9IQOSyRfX//CdjqHqd/AF6j30G7dVIAcNIvMTpvgT+Bzn/1BVlpJqe7gHw9VbA+i5NF1YBbdr3
	iN/Pdyaae6plZDQYBWCOPiSMcmLw7UK50lcuolUFnDdYfuioj7fGRrqPXR/uoRJoTGMKbFagPD+
	YlkW7dhzDDpg+zKrMaRil69YjAaOZp6Ha1iUQ/yVZUnK3FzgDXUYhwCFUl4n5BarhaXH5mmZQY/
	7lBr4usSWUFg8elCQFnDDKvO46f+G8Xmj/+awUWJklGPGxdGT5005JcwACLgeAF8yBAHvmqlnqt
	emmugncF8ImQQ9KYXTzB0VGXdMIR91BupEWZznAxCvnzNSXydy2COVTObbL5K6Qwe8LvLX4Bpps
	UxekRqk48j3E/eWI5OuYHP5go/tZYcaeJkY+XZZ5ZXUKwxCfuZHteVV+5wiuaD9HPpIBtzMAOWg
	oHQ45XquTWRHk8spxmNcY7Dqf45/W8nLNWu4fyDqL4yep0eSQdpz7r4Gu0VT4k/g3ls6fv39v6l
	jpkAYs1gYS58=
X-Received: by 2002:a17:907:36f:b0:c51:2497:c64a with SMTP id a640c23a62f3a-c512497d81dmr169697366b.48.1795081886833;
        Thu, 19 Nov 2026 01:51:26 -0800 (PST)
Received: from [172.16.220.224] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51231bc213sm95057166b.12.2026.11.19.01.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:51:26 -0800 (PST)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 19 Nov 2026 10:51:25 +0100
Subject: [PATCH v4 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Fix
 DW9800K support
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-b4-dw9800k_cleanup-v4-3-df26c431595e@fairphone.com>
References: <20261119-b4-dw9800k_cleanup-v4-0-df26c431595e@fairphone.com>
In-Reply-To: <20261119-b4-dw9800k_cleanup-v4-0-df26c431595e@fairphone.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 stable@vger.kernel.org, Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795081884; l=1266;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=mcLSV3KKUJrX2Vt1xs2+yh4YAv9r2QOuUzb8TrvhqBU=;
 b=CQYSyNjBO0Q/zSTuxeXLUaV+HvnPHo1DxvGi3LDOgBjJK0F1h6E4ABmNBlYJUC/6ZLjkTYYtZ
 +LHwZi/bm3XBFa/c3yFLbAkh37pXvffc998eC7/JZuRzWEqRvCwkvKu
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Update the node for the DW9800K for correctness.

Now we correctly select SAC3 mode and enable timing-control with the newly
updated device tree bindings.

This is a breaking change for a part that was previously functioning,
but only due to manual register writes in the driver. Now that we have
the correct documentation we are able to update everything to ensure
functionality with other devices using this part.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index f41ad446a39e2308abaea68a6b31a7e387881bf2..a657a5dcba9cdf750fab2478ca319f3a592ea295 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -665,8 +665,9 @@ camera_imx858_dw9800k: actuator@e {
 		reg = <0x0e>;
 		vdd-supply = <&vreg_afvdd_2p8>;
 
-		dongwoon,sac-mode = <1>;
-		dongwoon,vcm-prescale = <16>;
+		dongwoon,sac-mode = <3>;
+		dongwoon,vcm-prescale = <0>;
+		dongwoon,timing-control = <16>;
 	};
 
 	/* IMX858 @ 29 */

-- 
2.43.0

