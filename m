Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984711DA23
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742717; cv=none; b=DNn3YEwhgAZG/uq1mozHG65CbECQ/H3tZlmCZ8tb4Nh+PeAlTBBIhjoxUndbLbWtrvwrtTETr2npKRjYSgm69uoW6vaS3c+5QUHEbS/EF6w24lTMeU/brs1nu5TUdrJsF7woIBh13DLji3zEsWkubZoBplzt8Z5t+axtEdyPZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742717; c=relaxed/simple;
	bh=GJ9uKjGYjcwllQmXCmJ+YD5pxhQtYuE3vbzD/SvwN8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdSlJMbAmoOzPtxkZ5sklDTpajwd2J4bqU5J98QGxO2Ftg23/xpOHbZgjTZiXDq51cZl9I8T+5HyQaX4XFXOBL+gYFeGYMnq/ryHqIaTTw0mnyPx5/Hw/ViZsjrGhJvxsAeN8S1baCCJwXL1CiC/ID2Jkjwj3jKAaPBFhAogwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=JE/RRv4A; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="JE/RRv4A"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30bd47b9f0fso422786eec.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742716; x=1782347516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3CM2C2KRHWrrR3WjkFzhJ0JHlZVbVBlFHcHVIzqEq4=;
        b=JE/RRv4Aairo9OUox9Gjjx0NQxueUCCv/0sCgwiU+Atd1+dpzGkfRdZlxMaVHkR1Eq
         AQDFTKnDJnNOFZ7Crg21RYvEq5ExCcyVZ2lPCdQ+0fEpAcN/FtFOJtNpLLQ3dnakJ8n1
         msddk0kX2gaDK/mnVEIffsSSEeIdbbzMKA+4sxBuQWDjvRZAT9DzDEwcUMyIvuOPxk+0
         wxQr9e2XXYbihi3VENgqscTf41HRTGUJN44F4OA41clxyfIW3UypZtmZxIqm3Eioz8QK
         bwYVqBvf8kjnK0KQASbgfHPXiHmA8L1zJfXmbJHTAPoiv1DVxkHzUuJUbPQmOyKmiuk0
         +rnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742716; x=1782347516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U3CM2C2KRHWrrR3WjkFzhJ0JHlZVbVBlFHcHVIzqEq4=;
        b=m1hwfRQDGBsZfxmdmKOLSVK5PL9cHbRtJY0DvVWssl03XHGhjA78tdWB/tw7cpnu/P
         CuctY3OAQGDAazRG50jZbxI4Y2qz8RjBp+0v2kW8FknDgFEPZq3+w6N7IsAh5+h1zSUN
         jvwt6nEstlGtwZFGqxIUyInvT9ZQGHR6/XWrpAD/oRGW7nbVIpPSOujYQYLP59vx6VHW
         TKhWb8pgX/VWGqGckx4gO6MRWKB/hTwUjSj/DPjjZGwgLVBKIdC0cwQJXumLc2Ms2GLY
         6joZ6QcL8UEiEhRmKFKNtbEaLC7UQChMTjuaUaPi81NjVmt6gwA6SUCyd8/lvqR7t5A6
         RSdA==
X-Gm-Message-State: AOJu0YwFOpj80O1mpuRnjt6GD2XKsmNFuNM0J9cg0ZW2fLs8HP7WvNzk
	yFgaS8+jCbUN/Q2WPwS4XYLv+PeTZjPLarNFqq65SySD8zeDeR2GFWRK6wkmLqE+TU1tcnR0Oa5
	byU73
X-Gm-Gg: AfdE7clUztWa2eJ66+ykb884JxvFe75sUCgJ7zpTxMqt4vlWWNkhttDsEvwMYd4PKLb
	JPG3vv8/jF/IgvO+L3L27jzENPmjZBASmlHUKVu8oihBiSaJdoIxhpHyT6m1mJNo64YoyLagvxM
	PtVpZxg1EhJ+FUz4gYIowveNn/TQz6rVFbTJerVc+I7GW+G2yFDfOxjIO9/umUEMfSkWW6ls2CI
	wrug8MXrEgnORKpUixlMTWM+iIpNdWIeshujlgLG7XiBWl8o+K8sajSdsPPgCSUC0cpB0DyKgum
	NLhur9LLfn5naMOOrRluq1bIqqgIQ21pEAA3zZLqyIzxq2Y75TueiZWbXWa4X0wYTtnSOjvPJFp
	m1Kpu8lj0ffHbX0ElB6h4a9ejk4X0QNfW95Ya8EjgqQwFt27hNZ/g7HBAkI5ju0qi555qp6gkwR
	pBhfvzHbJAag9+V8zsCpnAW2BrdcIRsPdhIA==
X-Received: by 2002:a05:693c:2d8d:b0:304:ccdd:594a with SMTP id 5a478bee46e88-30bc9aa99cemr4233228eec.5.1781742715747;
        Wed, 17 Jun 2026 17:31:55 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:31:55 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 23/38] hwmon: (pmbus/adm1266) include PEC byte in pmbus_block_xfer read buffer
Date: Wed, 17 Jun 2026 17:31:13 -0700
Message-ID: <20260618003128.3112824-23-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
References: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 487566cb1ccdf3756fdd7bf8d875e612ff3169bb upstream.

adm1266_pmbus_block_xfer() sets up the read transaction with

	.buf = data->read_buf,
	.len = ADM1266_PMBUS_BLOCK_MAX + 2,

but read_buf in struct adm1266_data is declared as

	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1];

For a max-length block response (length byte = 255 + up to 1 PEC
byte), the i2c controller is told to write 257 bytes into a 256-byte
buffer, putting one byte past the end of read_buf.  The same response
also makes the subsequent PEC compare

	if (crc != msgs[1].buf[msgs[1].buf[0] + 1])

read a byte beyond the array.

Bump the read_buf declaration to ADM1266_PMBUS_BLOCK_MAX + 2 so the
buffer can hold the length byte, up to 255 payload bytes, and the PEC
byte the i2c_msg length already accounts for.

Fixes: 407dc802a9c0 ("hwmon: (pmbus/adm1266) Add Block process call")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260515-adm1266-fixes-v1-4-1c1ea1349cfe@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index ff7ebd9b2935..a7a440c09b52 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -61,7 +61,7 @@ struct adm1266_data {
 	u8 *dev_mem;
 	struct mutex buf_mutex;
 	u8 write_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
-	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
+	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 2] ____cacheline_aligned;
 };
 
 static const struct nvmem_cell_info adm1266_nvmem_cells[] = {
-- 
2.54.0

