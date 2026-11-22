Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343784;
	b=Fspg8BeKS1ITrtNsXxC75vmk3BYkjenYw5bkI95OwUt0J/73R1n5/XTlQJNug7/+aBEV
	 ZZPsenxDYQnWwGO1APCJcbe+K0BM31RbZT1k6MIQ2PV0QZeKcGWkrQ9kzey1JTRrLz2YW
	 0tBdn/SKW/ZuSKm7cC/GvXxq2kWSbMh9QotA4vh8K/Bp197uppEu7FvYZrQv64d2M8Dys
	 41Xsti2vIPR3yIMRs7FFyO3N1rUVzHYb9UunFD986xbU0AA0/TaapjzcLL3M5y9y4k8kG
	 1tOuoCJ+ZIguHM2C0bHyM/Jik0x/R+N89JBBKLPtXIWeaT94Ezn/xDJwjdvZqXmTWSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NFO8ABB2++Lb4Qniw60fNu+n6Ox71u5p1UIy7s61ddc=;
	b=GxdFKdQy4/CWEh572Obo9uutqAjyOVGOfgxATfMyuT4i/Sed0o9dZU11NTy/M/D5ykbS
	 DErMAExzzpKPmXxidpmg8/h4VVGZH7MsV/ZTs7VDqiBmXDY2uRzW8lRbG7oYIOxmywFoK
	 hxfXZcYjmqtR5pojZkmg2NJmWPFb8IlAmKCLtgohYbkgbBHRlWjbtKN8Fl3OuEaHAP5X5
	 BCL1JoB6nVEzfpSjAkMfzIR1eHJPoLbtcb4k39Y+YDvXs6yjMtJASOktgnHrEdGFmLZcH
	 z1x7XtGM7HUOP/sTs1f6W5gatIb2UzmoqmLwQ1qYResx8MctB1Vnjbd5tDjHR66xTqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bCcPs84Q;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62354606A338
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 10:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62354606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bCcPs84Q
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso5202779eec.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 02:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795343782; x=1795948582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NFO8ABB2++Lb4Qniw60fNu+n6Ox71u5p1UIy7s61ddc=;
        b=bCcPs84Q8MYdYT0X0Bg0dhFEe41xvC4BLYFYIgvjMg22VLdC9WSL47hQ+tfl47Cc/u
         OktulD8NotuMYcw4+w0akb+FEpn+QcdMWFtGMNyhRT6wjIdzK0tiwfGuC8QDjEStM3Bi
         5UBP7f5nMjSDbmNUVycWUpwL0dJYSwg1x8V4jXy4N34AXF2lXp5tzF9vt3lVOLb3yVRS
         17oKRQN040/K49pauZHoR1u1voRXfmnOmgSIbrNFbh7JTH4Zi7pUf0i+iq8PqYRxVHXk
         xe0j0LMUw4uEZBbuFnYm9BuDXtRe6sc705osle31d37Iab39b7mc0NU3921rMfrL5BKv
         VKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343782; x=1795948582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NFO8ABB2++Lb4Qniw60fNu+n6Ox71u5p1UIy7s61ddc=;
        b=W0NlsqQ5AXd4ST0dACmA3hbZInGYKzjWE0X/AXVOdUkMng8h8A+6mMbBITR42p3pfL
         91Xn7E2INuUBXLqkcM9mCFENwgtGgZ98sZ9EB0KsFxZq0uA9DP43G2O+6NT36m2GimbU
         NjJXR1q+ConON7h7OjrRfVV/PPf275+6r8GfSlgR/A7uUdt9srq5irtpkhWfKqJchfBg
         SNk4h/fAOOmvqXI6+UsK10S+ZDSd7kEawsq7vPp5H7Twk88Lz2AcLDdT+WRUeqQW+/qL
         mjqZybTfFDI8xhUEwF2TwuTaOs9wZx+0tMNf6zRyjFlCrwzhqLMTM5yhIkdIN4pMeSCS
         Zpfw==
X-Forwarded-Encrypted: i=1; AL+hErHsxWdN9jsefHA+zPgdhXN4O4SqoXkDyWd6AjCXRve4CJMFqgEkiNI7diymnPymZZH5uNHr/8Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZnJNRDoFV3+1OJysVvzupofaNyglcJ4MrvzTlzKPB0yj9f79r
	/kIWQlipuvVm81gjNOp53jqKu7DVRo5nVKcVud/lY6DD4XPN7MXcWO74
X-Gm-Gg: AZFdTZf1MjFknodHVkq+VXeTevdBgKm5hPsgjlISQGuq4rTyRmGwD0bT5vT2yYBZEXA
	yvjTsvaOUk0QrmjIDybVLtgH5JHDiibcl/7xdOqqiCSO9YAvu1DC/YKBRFiLQux0ixQ/h/Fu9hR
	UiW8uIwCeG4wPxX4qhQOQ2KcmvGRpU0DiDvJi4dd4QnOzTajK0G8qtYqXtYI5qUvQ5Y6mi2HlwO
	EN0ikslSkAnTrm3Pbt5WnnBo3TMZX9bVSomzi7t1uyl7iU4CBw1V36+79Bnsy2dC/ctljbhNZIs
	bwZ+LRBwIpjLmwFneoMbkf+qAkqqDQoQf2D/ChpktOc4W5oK3EhthU7UgxiLyYIRGJIvxDVIsij
	7YlQmuUczYVVLVQfVXCQSwqmJo484Gl1GuRrRyWuV1Dfo5Cwk9CTxDU5LbtUGmloOxyFUnRCmgY
	jTIUeLwppSdGm9grfYGVn2qhqHH2LueAneokIeF1IyX4w3XGlwHqZ/4B3Tt2GLKUohkARg/bPZe
	nq8ixsdDoGeKuhWeCnZiW1nt4MVm9YpQif6o73fP5hhiuaj/HF1VAautiL+dbLQz2NdwnemUCzC
	rGJtaY86grhTdjnf12b6IU5ieK5dM9gGaNrG+/e+qBHFd2RJfocYdjAwDmkz9FBBYyaxQ8EkCMU
	haDPF5Ky5ef2rTHVIApLC7gWKDniNA1ECHWLUmkUN
X-Received: by 2002:a05:7300:f68e:b0:369:f291:49da with SMTP id 5a478bee46e88-38571814b1dmr8880157eec.40.1795343782479;
        Sun, 22 Nov 2026 02:36:22 -0800 (PST)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385667decc2sm26176803eec.9.2026.11.22.02.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:36:21 -0800 (PST)
From: HyeongJun An <sammiee5311@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ALSA: seq: ump: Don't drop MIDI 2.0 RPN and NRPN for MIDI 1.0 clients
Date: Sun, 22 Nov 2026 19:36:10 +0900
Message-ID: <20261122103611.3264343-2-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122103611.3264343-1-sammiee5311@gmail.com>
References: <20261122103611.3264343-1-sammiee5311@gmail.com>
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

The cvt_ump_midi2_to_midi1() converts MIDI 2.0 channel voice messages
for a UMP MIDI 1.0 client. It has no case for the RPN and NRPN
messages, so they fall into the default case and are dropped. A pitch
bend range or a tuning set by a MIDI 2.0 client never reaches a MIDI 1.0
client.

The core converter, cvt_ump_midi2_to_legacy(), turns the same messages
into CC 101 and 100 (99 and 98 for NRPN) followed by CC 6 and 38. The
program change case here already sends the bank select CCs ahead of the
program in the same way.

To fix this, deliver the four CCs that cvt_ump_midi2_to_legacy()
produces.

Fixes: e9e02819a98a ("ALSA: seq: Automatic conversion of UMP events")
Cc: stable@vger.kernel.org
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 sound/core/seq/seq_ump_convert.c | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index b42a7ffbf31e..e76fdb54df17 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -432,6 +432,38 @@ static int cvt_ump_midi1_to_midi2(struct snd_seq_client *dest,
 					      atomic, hop);
 }
 
+/* send a MIDI 2.0 RPN/NRPN as the four MIDI 1.0 CCs that select and set it */
+static int cvt_ump_midi2_rpn_to_midi1(struct snd_seq_client *dest,
+				      struct snd_seq_client_port *dest_port,
+				      struct snd_seq_ump_event *ev_cvt,
+				      const union snd_ump_midi2_msg *midi2,
+				      int atomic, int hop)
+{
+	union snd_ump_midi1_msg *midi1 = (union snd_ump_midi1_msg *)ev_cvt->ump;
+	bool rpn = midi2->rpn.status == UMP_MSG_STATUS_RPN;
+	u16 v = downscale_32_to_14bit(midi2->rpn.data);
+	const unsigned char cc[4][2] = {
+		{ rpn ? UMP_CC_RPN_MSB : UMP_CC_NRPN_MSB, midi2->rpn.bank },
+		{ rpn ? UMP_CC_RPN_LSB : UMP_CC_NRPN_LSB, midi2->rpn.index },
+		{ UMP_CC_DATA, v >> 7 },
+		{ UMP_CC_DATA_LSB, v & 0x7f },
+	};
+	int i, err = 0;
+
+	midi1->cc.status = UMP_MSG_STATUS_CC;
+	for (i = 0; i < ARRAY_SIZE(cc); i++) {
+		midi1->cc.index = cc[i][0];
+		midi1->cc.data = cc[i][1];
+		err = __snd_seq_deliver_single_event(dest, dest_port,
+						     (struct snd_seq_event *)ev_cvt,
+						     atomic, hop);
+		if (err < 0)
+			return err;
+	}
+
+	return err;
+}
+
 /* convert UMP packet from MIDI 2.0 to MIDI 1.0 and deliver it */
 static int cvt_ump_midi2_to_midi1(struct snd_seq_client *dest,
 				  struct snd_seq_client_port *dest_port,
@@ -499,6 +531,10 @@ static int cvt_ump_midi2_to_midi1(struct snd_seq_client *dest,
 		midi1->pb.data_msb = v >> 7;
 		midi1->pb.data_lsb = v & 0x7f;
 		break;
+	case UMP_MSG_STATUS_RPN:
+	case UMP_MSG_STATUS_NRPN:
+		return cvt_ump_midi2_rpn_to_midi1(dest, dest_port, &ev_cvt,
+						  midi2, atomic, hop);
 	default:
 		return 0;
 	}
-- 
2.43.0

