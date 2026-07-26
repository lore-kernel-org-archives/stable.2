Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60471380FDE
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785064546; cv=none; b=Ze+8/guT3cDYBPg7j1NEcuUj3r8+f6Gy+1JOmisyoELzSZPK8baALUSEqWyRKW3IeW6X/2QQKl2lIjympjLEfx409Tk6Jn/BwREyUipOm7CRsKXMYu195mfcpHpH5Z2Sj40TLl28G/DH8PdTDbZ8inmnnSCve66f1EipbKUvGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785064546; c=relaxed/simple;
	bh=XhVXEKtqspLI441uWo3QuIRBqXLhGYrFvjuFf4r/qj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dlk1b4Lfu1EbIzIykJeyqwh68JD/ZLMxSWtl/xS346HSemjq5C107zay9o84rmc/TqKMjoqjZJ7R1+xUwpXLEubvQUxwTh9UdvobFsfcSl6m75yO6V9TayeRl3no07LRcWAGp+8e/VOhkaNcSfjql4kdGB2vQu9y5kox7JHZtOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pu61xWw/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu61xWw/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cca0c5799eso16571245ad.0
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 04:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785064544; x=1785669344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k9b9/6dXenhTUKOJCIHLIq7fadOmj44kmHH5pPyMEgE=;
        b=Pu61xWw/gcTWeL4Waw5O6OCK2yzwBBWqHBdNfUsKebEW+AlTwf4VXbttAzCwZLPt2m
         DxCnjeeODXwdl0Cm1VOBCsGxOOpcFkchMdYV7H9H0fk5z5hkCY4o6PIGeBYIOD3eAYAz
         kj+Sqi0lPjEK9c/c4p6m2Thf9W++3pdp+Sm1pzsRuFG4IO1iQF0tbYqKtMPDN4jZiRwR
         H+avA/MrHnUqjdNs8l4NPQwlTmH3i1eI+TUGntZeTjJVY1O8fd2bh8KTfh2hX4NLSl5/
         CGdjImmgFaeUBvsDEGUskr821KLaOqBC7W9H1MFA85YxS8G7QULmoIdwHYqI9EdHvOnG
         D23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785064544; x=1785669344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k9b9/6dXenhTUKOJCIHLIq7fadOmj44kmHH5pPyMEgE=;
        b=gVhAWGUkyCBn7hhhzG2wFyCy1BM1dFlFG6/EU3Vp7RQTsmnzdauyXSFLkWzhzo3tcV
         yqsN25Qk6UaqaMJOXX41gioIehP9ShJ8FTkqnn9XabP+r+O5X1LRzd4jIkMAbBOjk6m+
         lzgpdl6TKAryqHCxYNiNlcPTcDXjFBjyAlFtLUjIw4V40W7HTJPcbQ7BPPzcpwGhvYzQ
         bRW6b+s1Z0bFFDvQg//0oNNWPZ1C4H9vLgVd77GtSoUVCpUHxFt8lCy9eBPJSsvpltko
         RMQBzMfQLmnCbflR+44lxYJkBnfAcS07g8mZDt5JVjKdVgvK37bA4vX1Q2ZTlmgAvFb0
         ZhaA==
X-Forwarded-Encrypted: i=1; AHgh+RqnnX6ZdmlSzmrgH5FcLquh7DEESZ7wfqRPFYsSpubdmsHkETUTq+mqJYjmIAYTL3DXlyKTcAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAplJ/itk8URy3l77lwuonwK8qAgBCMzjuHm6tqKgjtux3X65
	v8P2I0mhLnLmppiGkQ27g6uPKRykPCJhCdcWEJEbSpdBpwu7F3/eAWxa
X-Gm-Gg: AR+sD111+/McyvaTiAp/mcTUKSKuQuL8a80Sps6//d56PQAAZKsqcXVnS2wq2p+Ovup
	WWkcqx2/BTzEoKVBTXcfz3aCWa+ub8U904/M+unEcVA6rqrnQmLWkp1iTcib87r5lQ1lxEo0a4H
	r3uoKwj97Bul1aLl9t6DXYiB1G0WRa5SBxN2SXVRtp6BvCSrie0v/Jxy4Vb8ecwqpxLljPfQYwB
	tGX7l5Bn8duD9lv7R/SXplLry7f1R59VYtR9WiNVFVJ60g0nmm9RqmH8nlorL+ajf418raEzYJg
	8E8Wy/vVC5mTMTQy9Aq/1pjnyUmE6vbCTimOwIK6X7F7Nyok6RSufBCPXxctkrXx6cHiy6WFwEd
	ogSXrvCa6I9juI0r6Gbm4d8ggwJwdH+YQOP7MzNftXBhXdMqZnJ7KR7+m5EwxD20MZ0NrUT0b60
	Tr3KhqnS/hWDeWycsxfWTphN4qMf5DfITVWDyiHXV4lrCmg8fW
X-Received: by 2002:a17:902:ef4f:b0:2cf:83bf:6b05 with SMTP id d9443c01a7336-2cfde86bac2mr42423935ad.41.1785064544371;
        Sun, 26 Jul 2026 04:15:44 -0700 (PDT)
Received: from lza-virtual-machine.localdomain ([120.236.174.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bc585sm19192805ad.51.2026.07.26.04.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:15:44 -0700 (PDT)
From: Zhian Liang <liangzhan5dev@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhian Liang <liangzhan5dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] Input: tca8418_keypad - fix potential infinite loop and OOB access on invalid keycodes
Date: Sun, 26 Jul 2026 19:15:02 +0800
Message-Id: <20260726111502.2252-1-liangzhan5dev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the hardware returns 0xFF (e.g., due to a stuck bus or device fault), the loop never terminates and
the extracted keycode causes an out-of-bounds access on keymap[].

Move the empty-FIFO check to operate on the extracted key code so that
the loop terminates correctly. Additionally, validate row/column indices
against the configured matrix dimensions before indexing into the
keymap array, skipping invalid events.

Cc: stable@vger.kernel.org
Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
changes in v2:
- Moved empty-FIFO check to operate on extracted key code instead of
  raw register value.
- Added row/col validation against configured matrix dimensions.
- Dropped explicit 0xFF check as requested.
---
changes in v3:
-Fix mailer line-wrapping
-No code changes
Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index b124e576feca..36d4a7c38bb1 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -114,6 +114,8 @@ struct tca8418_keypad {
 	struct input_dev *input;
 
 	unsigned int row_shift;
+	unsigned int rows;
+	unsigned int cols;
 };
 
 /*
@@ -171,19 +173,28 @@ static void tca8418_read_keypad(struct tca8418_keypad *keypad_data)
 			break;
 		}
 
-		/* Assume that key code 0 signifies empty FIFO */
-		if (reg <= 0)
-			break;
 
 		state = reg & KEY_EVENT_VALUE;
 		code  = reg & KEY_EVENT_CODE;
 
+		/* Key code 0 signifies empty FIFO */
+		if (!code)
+			break;
+
 		row = code / TCA8418_MAX_COLS;
 		col = code % TCA8418_MAX_COLS;
 
 		row = (col) ? row : row - 1;
 		col = (col) ? col - 1 : TCA8418_MAX_COLS - 1;
 
+		/* Validate against configured matrix size */
+		if (row >= keypad_data->rows || col >= keypad_data->cols) {
+			dev_err(&keypad_data->client->dev,
+				"invalid key code %d (row %d, col %d)\n",
+				code, row, col);
+			continue;
+		}
+
 		code = MATRIX_SCAN_CODE(row, col, keypad_data->row_shift);
 		input_event(input, EV_MSC, MSC_SCAN, code);
 		input_report_key(input, keymap[code], state);
@@ -298,6 +309,8 @@ static int tca8418_keypad_probe(struct i2c_client *client)
 
 	keypad_data->client = client;
 	keypad_data->row_shift = row_shift;
+	keypad_data->rows = rows;
+	keypad_data->cols = cols;
 
 	/* Read key lock register, if this fails assume device not present */
 	error = tca8418_read_byte(keypad_data, REG_KEY_LCK_EC, &reg);
-- 
2.34.1

