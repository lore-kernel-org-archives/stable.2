Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215238;
	b=jlUWtuGYrNLLU5dRHwd8l4QzcFTAr1FCvfH+TELV5r3ChW5MKvBUwx4nhxBoxtt5aF2u
	 maqmUvr1DkxC5ocmLQGOKN91uJ1DcLtN+BO64qnIX/bzrD6pDHFazgXIUAcHAtLXIr0IK
	 ZZrA001AjuCgm+I6bCqfYQs5plBWC79IKtM2zGcPPFOly7JdaFyAS3Pwx+hH+Ft360Zg8
	 MwfRwsxCHU86/qxZJCE6UI8n8d/VGcF42ySIug28YAzzYg6DeR6gm/bhxnjptzrddGnAY
	 aUAK6+Z4/r4CO9iYk5itZ+ftXQa2ZniRdiW/YVEb4p0n4oi0WgjZdRYmVb0dJVaJWyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215238;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=whC+VMiXAPUTUgOglDxaMp+60RaaaVmq7RPmjGD/+W8=;
	b=hMXaeDfqaYHqF9/bhmqiLrv8N2f9+CmwZNR2vIoj5TRmgEmlXDha4oEUFfUgwCKXCqdC
	 h4aF3cD0t8hL1tQuipZL6fd9NHeyD2uskZr51u6wr/uj2q/l+X0bHhsOT7QIPXk1q/SvL
	 pS1H2bjp5UZelRJtbBpxGLPsx+Un0JsoXltvCJaPiPuadX06ZI3jMqV38UlOgiFuRx69v
	 IjZu+D5YGEhmNhgkXPJsGkP20t1IBulDg5xsNACfWL5az9izUp0Qp64uPkHPuBU7Fh24e
	 j3z8XX7y8DFR+isOI9uhZhqOI/J9fiCQqFBYc7P9fl/qvh1WBEHt1CsMPWIz1WxtQww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=XySRePvY;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90903606A323;
	Mon,  9 Nov 2026 09:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90903606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=XySRePvY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794215213;
	bh=whC+VMiXAPUTUgOglDxaMp+60RaaaVmq7RPmjGD/+W8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XySRePvY/WdXCsKXDE4GTwSgfLioSXbO6yedslgJuUQgEXHa/URvYh5d8cYuNGj95
	 ASOIJ5IN3iZAps90sbELj2bk2Weu99K56Z+yIjEnlpfPnYTQKYWFn68vvXmjTzQhMU
	 x5OExMIeeO5zSubILctVRpgmoPV9zxabSVeqM8Co=
X-QQ-mid: zesmtpgz6t1794215197t346d00b5
X-QQ-Originating-IP: WQqp4mf3MsnLgBQ3+XZfeZNdYNfI8ePL6pA5y8Z2lEY=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Nov 2026 17:06:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2241864079019500270
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: lgirdwood@gmail.com
Cc: broonie@kernel.org,
	robh@kernel.org,
	mka@chromium.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] regulator: vctrl: Calculate OVP delay before updating selector
Date: Mon,  9 Nov 2026 17:06:34 +0800
Message-ID: <4B7D8523DA6FC75F+20261109090634.3762484-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MTGYztYhR5ETyfZumcjdLN4B0Gr1nGsZ158O6UAHnTEKwg1ZOp3occ02
	4LKD6aO1ERSsNwXO18OeYozD6gFob5QsAiSujnXMIYSAUP1DDpR/qFwoPtZrJkey9TMba+w
	gAnr05GW+dGp+ycMhmCCIEkCQxO3xeyqdZeq34vF94XB7Q/czl5psCOjlWdbsfrrL1qytGW
	kcCT/YDnrXILnsnTrvc+JvVY6TLKVfYzdkAB0g1FNKcQ2CHmg8RQOCXGaPl7Oa1YH4S/cCA
	/dPcY8knq9WI9yqAu+rSQch+WMAUBgVqgklGMIy5FEDlKBBFyXGlYwhpWuMSqQTTOa0aCp7
	MS7ikw7gll+MpZzK1myT72cVkaJMUlh3djZsQXD0h9S0Js56HVd8/ciZVEJKeoFeizCXEZe
	hnImSk9stoRxmvdUN5A1giBdLaDVxH2xB2IgzBo6r5x/M3gLqVzPZmkohQjVkglYwiZOCcY
	BbhJKC42KwEQAqwAMu/2pjcevAutz0dKPhiNMoYLXdtZdd/WvC9t0W0r5rTHfww/XjZY0Bo
	NZbYo4wrLKqi8MHbmh/9T7p5PQCep2x2nXG2Umvh5V4bSGjF/WWAPrF2LvgWFfeLauMcWB2
	MDwmahH7NBprAl1ts6JuXDb3GAvY4YH5+AyNquZgBxoROyYpFtuD+Zl/f7dMLmjoarV9f9F
	6Cuk49Z8nys1qAO+nOIB8DaSsdulidlb2xGCW4JpY5lk1aNHFYwOSlpKiBntX6mCca8Ln2S
	eLeTTUzt6Bv5Kf/T2RRB7PCvv2FjEH1SQyWLPMxVOJMSzLnh9aBZ+81IvAg/E0oFubXrICA
	eLfrvjl5adQi2rEUTNxmuWQUx7X8kpeFKVXaXjPRetQIbyprdANfXnYC901TBrHv1TpAUh6
	RAXAUPMOsSIkE3tgqzBbBwumXF5RSML3IFVgqWnvoys/+EHNjfDJrvBKu7JwlqSiHU8XLFg
	l++EPmltxlDoA3XsxYuXDbulttN6c1n2Hq/0Q11zlNFvAXoCeJM5TbQRqnzqyFQLAB3ZZAL
	4LCsHb0nJSJdPmGlyw9fdbGeVHZSNeUNrcNcpV9zg9K60Jj0nDQJVGyuvRxfQ=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

When lowering the voltage with OVP enabled and a discrete control
regulator, vctrl_set_voltage_sel() splits the transition into steps
and waits for the output voltage to settle after each step.

However, it assigns next_sel to vctrl->sel before calculating the
voltage drop. Both voltage table lookups then refer to the same entry,
so the calculated delay is always zero. Consecutive downward steps
can therefore outpace the output voltage decay and trigger an unwanted
OVP shutdown.

Calculate the delay before updating vctrl->sel. The voltage difference
in microvolts divided by min-slew-down-rate in microvolts per microsecond
gives the settling time, as documented in the vctrl regulator binding.
This matches the continuous-voltage path and preserves selector tracking
for subsequent steps and error recovery.

The supplied fix was reviewed and this commit message prepared with
OpenCode AI assistance.

Fixes: 9dee7a72d0c7 ("regulator: Add driver for voltage controlled regulators")
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Cc: stable@vger.kernel.org
---
 drivers/regulator/vctrl-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/vctrl-regulator.c b/drivers/regulator/vctrl-regulator.c
index 2796580a3a3c..d585eaae0433 100644
--- a/drivers/regulator/vctrl-regulator.c
+++ b/drivers/regulator/vctrl-regulator.c
@@ -197,11 +197,11 @@ static int vctrl_set_voltage_sel(struct regulator_dev *rdev,
 				vctrl->vtable[next_sel].ctrl);
 			goto err;
 		}
-		vctrl->sel = next_sel;

 		delay = DIV_ROUND_UP(vctrl->vtable[vctrl->sel].out -
 				     vctrl->vtable[next_sel].out,
 				     vctrl->min_slew_down_rate);
+		vctrl->sel = next_sel;
 		usleep_range(delay, delay + DIV_ROUND_UP(delay, 10));
 	}

--
2.50.1

