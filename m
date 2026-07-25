Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5F35F193
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784967004; cv=none; b=th8FwGXPPtJLT2PkhfgfIoLbcbwetPLmQPWBQ9y3IeXg9qJxs43uIQdegfpNsgYB4ivJaojksyIH4lyD4BdDw67NUJ26UKAqiEgb1pO0Oyadn5LGN4o9LoOKx5y4wiKhk48I9HmBgoY7614+Q5yFPOuPDvTTJuPS9ouEychN3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784967004; c=relaxed/simple;
	bh=J4ubHfAG14RsKXJlUSfmRcTuEjOmQ/zOrQeO3Pc5iUs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TYVQli/fiT73L3a70owkokvfp2FV5kg4wG5oCYHJvMHDOArwi+50c7Sj+QZGnrUBjYAW2NvHvu4dVpcl0FeHnpZW4h3xJ3klZPWzIUtHku2llmoNHIyVMqhF242/gpqoQDD0GBBIS0zGRI857ao62yDf4nYpltmmFLuEJHoQXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVEmJ22o; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVEmJ22o"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84847482584so871262b3a.0
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 01:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784967001; x=1785571801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4J2s2FhuNzF6m2XUI8QthmE7XnJnr0cmxqqYW9+XQCk=;
        b=MVEmJ22o7MyrMX1GywGlwJ5XAB4vLJFIm1IWgh8JkYuXfGfoq0aW79iOg2U4ozLM5i
         ztYEz9t0Ddg5YTsqWFX17dS81GTA3Qwy6bvHZxCh7TvWfGqaeK4j0PYplFVMcs9wFCpg
         PKTr+tOqHlQ67K7PK7FYqMFgx0mkvg1DaBG/1vrZBZ2qkxtsxBRihQGicKRHK41c0M41
         wt6TrC7INAASKN9Nj0//EVAzQUaLRsBmFqOHqHwztq6iXz9XoJ9UuqXy5qjNAcxGf40h
         HhIsF594VFn2GAuoyJGM54KdMDqONVFpfw6MhnNR62LPKZQh/KFwx4/+2T82DMREGe6L
         cdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784967001; x=1785571801;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4J2s2FhuNzF6m2XUI8QthmE7XnJnr0cmxqqYW9+XQCk=;
        b=osPg5mOjmqWMI/FagyuGinAcVptyNgJT8//8mQj4ay881ixjx+kPOsMNif3Tu5qk+j
         6Qtu/y43M8cctF18Yt9H226DccRz/n8vFrOn40OxnghlU0GDCgeWzSXGGqrvtndBamEZ
         bYDlskYwZa95TRyLGboqCn30LOisOb77BJzTAfO/rZhBH3daPelSHXudtTeNzfJzqc9M
         2FUjl54pcklw0F4xEbcRxfLVm15oIiW3VfyxHAYR2v4ZxqiHfFbMAImaaAh6JAyqZPza
         m2b+ZL4eSsKtH2WAxccqfWSkrH9H1movoYKOsp5JiFYzLQRsb7dEvAnO33suZZgp8zI3
         /i8w==
X-Forwarded-Encrypted: i=1; AHgh+Rq41Kpw2Knm62puqvW261ZGKrJ90foyQlHBlSZVFT7aNTH88Y6329pU6RuYZsY0Ntw2PHEuqqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMVMtXHBP7Ez8Q0mBsbHLFsGveiT1jprlG3ZPECpGRGOaGuspd
	WFM0BRBS+7hpcgopBnqHXcyWjPVY4nbY6b7cl5idPUH7jB5SmOU7N0sgp8uf3NjW6l1jDw==
X-Gm-Gg: AR+sD13XdWKEQtnzXK7ck8tkl+pb6fk5JSt6/sxMKi9QgCFpuC3ImDzW8V6zfzyCjps
	dxMQBygAjyvIVLk5Ncx7+PRTTaBjegrBo5bw47abhR2S9gH16qIzWk3j0AWmF6tO4S8G1j0pfg5
	pN+HnnFb4BOw4shvvaXlV7W5QruGV7zkdC0XQP5cHAjJBK2hOpf21z+oSohKxqdPUQILLH8xeZM
	EI+mIJDAyzGXV+L25xSdri8WC4TH5BJvPmYu2SeiISBsfov1ITQdJQhm3SZJiEl98oB6I8oCxj7
	QDygP/e6+m9M9ILyqHyURjUuwgUmpiju3RQYzzwXerKO1ZbOSfKRzlZEj8uEYAwpQ719sAiGO6D
	r66oPRDWn5TSis484d858YJptVCXCyLUYL/ovEHVo1wPsTu2LP+QVMXjtG0aaO90pAqfTkgQIJu
	GPsnt2nTXaGHgs1wyNnFUtQMc9lPAtgFhFNbzcd1if
X-Received: by 2002:a05:6a00:f96:b0:84c:2d22:7307 with SMTP id d2e1a72fcca58-84e5945035cmr1043472b3a.13.1784967000762;
        Sat, 25 Jul 2026 01:10:00 -0700 (PDT)
Received: from [192.168.216.190] ([120.236.174.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533ce1f7sm863654b3a.34.2026.07.25.01.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 01:10:00 -0700 (PDT)
Message-ID: <93177ed2-10ca-40a0-9efc-95d83913e59b@gmail.com>
Date: Sat, 25 Jul 2026 16:09:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] Input: tca8418_keypad - fix potential infinite loop and
 OOB access on invalid keycodes
From: Liang Zhan <liangzhan5dev@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <f03a892c-0961-4e07-a6e1-dbc3ff2064db@gmail.com>
In-Reply-To: <f03a892c-0961-4e07-a6e1-dbc3ff2064db@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The current code checks the raw register value against zero to detect an 
empty FIFO. However, the TCA8418 datasheet defines key code 0 as the 
empty-FIFO condition. If the hardware returns garbage data, the loop may 
never terminate and the extracted keycode can cause an out-of-bounds 
access on keymap[].

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
  drivers/input/keyboard/tca8418_keypad.c | 19 ++++++++++++++++---
  1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c 
b/drivers/input/keyboard/tca8418_keypad.c
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
@@ -171,19 +173,28 @@ static void tca8418_read_keypad(struct 
tca8418_keypad *keypad_data)
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
@@ -298,6 +309,8 @@ static int tca8418_keypad_probe(struct i2c_client 
*client)

  	keypad_data->client = client;
  	keypad_data->row_shift = row_shift;
+	keypad_data->rows = rows;
+	keypad_data->cols = cols;

  	/* Read key lock register, if this fails assume device not present */
  	error = tca8418_read_byte(keypad_data, REG_KEY_LCK_EC, &reg);
-- 
2.34.1

