Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622204;
	b=AO9y80WyoOepxwxBjSX6hc5FFlSv8MC4sA4zEH3sy9X5KHcU4oHq6eM9fk7TjTBGIR3b
	 0solAAqjnhqByevEkDLZB61rymUJYPvC2R+AdNWEiMLYw6vtIS5GB5GJ+CG+8sdchyxUK
	 deG8Et/b6wBgk4WnAshKR3ENiAazlVb1M+4/Wcv+RTPd+NwqNRT6jHC83YwwGg+T9hIBt
	 4sbO4K6zutKAGU9tP7v7cBeJT28b//1sbTpFS6psOFst7UwSSTm509aT2+Oc5vTdJ8WDG
	 0AtJ4rVJissV1LKotDYBSgWmU9h4qggPzgNOfs6iaFW1k/IDO6N9nrYNHe05lFJfI1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gKgdPxUwvGsj1jITDycK6PgHkA/hoEEzGZT6KHBzS7I=;
	b=izk1FV1Q/KtUkI654SOW+Lb2QInAF8zPsZCPteQiNUu2W1ZeZaQNe2nq853T5hifrS8l
	 RnRurWwFDbOAGjy3x92CE2K/SNh3hbOdV7OGtky2wt3EmedDS7Q+e1ogznaLvaP3z9icj
	 R8KEkY9Hcr/TRxD9+cxjb7TzBK/VXN40dYPun3zMD1AsHLNqKyrYf7SEjsOe5MKFMGQi1
	 TUZcAQwaENk7f3gqT0er7DXgpRycB3i5OXt2KlYWeOREb+EXBPv//3pkzKThcvnD7xTKv
	 nM0RlnswrZPR30BREvinBuMqosrIg7PHUv1b2n0izwA3BmKfp3oNpXvCoIYEViozVvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eqUQ/aSU";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37860A6F72
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A37860A6F72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqUQ/aSU
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso19323385e9.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793622203; x=1794227003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKgdPxUwvGsj1jITDycK6PgHkA/hoEEzGZT6KHBzS7I=;
        b=eqUQ/aSUpzOH/ouqbWd6Z6zeNty80SmGLbcaZU3kusNRz+1m/u/i/RSkegJ8/Sou7S
         gZQYnwajklbBSa5Lw5km2FvzhIy++XDjVGW1inLAj+Nc4fh/ih+rswNlYuFPTFU3AZkf
         5yTKbS8qNdo/L6V7n0sIDUYtB+voTA0rt2wx401gMbzpVeP5c4yTJOYAuI52p53ixdj4
         aMbs8tJHwDQvrU67SgmeZI1vrqQ1P5gvnqcP9u5zLRmx42PR8uYlRzFmzDMCRytDvLO3
         NlcGOgBRsBtn8DoRK5r4hs3t4L/hqIWa3zbfZyIKjIWXXLges79hhlvd05RZHkq8lREU
         Ei5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622203; x=1794227003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gKgdPxUwvGsj1jITDycK6PgHkA/hoEEzGZT6KHBzS7I=;
        b=fJsBbsZrOxBCxveoualiABGrOK/OPKgPg6g1rc6XaBY8LNLcc1dPgC+sUIsaBBH6sF
         aHMbxE8kR8TLmC2usZJ3jce0L7z6kqU5h5HnIYJ1NGmjw9k4OnLsVEDSKvFAonauw3f/
         Qd6tzdsXz8zsiDwttqwJsCfrZB7ZKyF6yKSoGB8J8F3ulZAmrIoYvaHv7i34xS3AV+k4
         ni2Tign79u0f05U5in02+SLeoRk0mTtjnux8nc89EH4dOBE45FQ3qnJOKX/bjItgVV8Q
         chFu5wo3+rBJDJOfhDANeAccJMpSuJ3SqK+FKHGtwXwsUoPDkskOOA31bNiu0nJ04kI7
         W5Yg==
X-Forwarded-Encrypted: i=1; AKwUvByJClFwxmGcUK1bHl1gl6Gr1rAUvFCT5XdLDiWWyoPKQF9YMZB/mD55NKayBS2SSLxD6Eyd+74=@vger.kernel.org
X-Gm-Message-State: AFq9FYLU7EAHnSEHpw8QecXcIozIYpHSMdDCe/Tdvur6vXnsh3/jI1h9
	PMQe3kmGoHRwJfNBVlbo6w1eOVfsllvu5ERQUp5gZn3w6I8/4XLkRN0=
X-Gm-Gg: AYBFou3rw8w95C5V0mWR26g81P6hA/lDvD2OTLg29AjBi6iZ5DZfT1AY1M1OMriU7M4
	4RPcwo2eg9NnaiyERprbaQXyUhZcLX/A40mdXsddr8fpPe41jF4qRJNW8Obo+nRC9G1fgMGUnkl
	mhgW25yiz8lkKoWAHqliQ8NmfniF6jp0Nr9a/UlaVZphDoCaN6uQNrEA+aCXcOiEHRKAcxjuYrm
	8nK7PTxp8mOLgl0P7oUdaq5lbj2AfEu1MUZ6ZJr9vItXOuD+NkMZ9fWWAKezRcekbV0AAfzaDqr
	eKDW3zVtUMWfQFoiVv+yPYS6jhsxJUY3IWx/M/mzOAvRvoVEL60WEeGyG92QhizFhYxTaB7y2u2
	loU5wBauhciCI8dPfwDKpfOdZw3kprmeZfSc5IK4sPS7xDwV7dmcKBFc49GIpi3WL5joybspvEG
	/661UoGpMpMRHYnNtRtACuZXZSadVRZRSltr+x37ufPVqzXnyU1MNOOE8sa+FCiW0vTsyam3WEX
	EmxCFh5iSAy14lubX/EsPC9wfgr0ac77tDH2MWXCn1F+X/hRr10OQeXiGslDaML6DrhxZdk0K3j
	IJBF+cUOz9FKQdWvxrY=
X-Received: by 2002:a05:600c:4e90:b0:4a4:f48e:78fa with SMTP id 5b1f17b1804b1-4ac175669e4mr221304045e9.12.1793622202606;
        Mon, 02 Nov 2026 04:23:22 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf67aa704sm255490595e9.8.2026.11.02.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:23:20 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: arend.vanspriel@broadcom.com,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	fariyaf@gmail.com,
	linville@tuxdriver.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless 2/2] wifi: rsi: zero-pad SDIO TX to block boundary
Date: Mon,  2 Nov 2026 12:23:11 +0000
Message-ID: <20261102122311.181075-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102122311.181075-1-tristmd@gmail.com>
References: <20261102122311.181075-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

rsi_sdio_host_intf_write_pkt() rounds the packet length up to the SDIO
block size and passes the larger length to
rsi_sdio_write_register_multiple().  When the packet is not
block-aligned, the SDIO controller reads past the original data into
adjacent heap memory, leaking stale kernel data to the wireless device.

Zero-fill the padding before the SDIO write.

Fixes: dad0d04fa7ba ("rsi: Add RS9113 wireless driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/rsi/rsi_91x_sdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index bfa386b820d89..8bfb08306d03c 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -772,6 +772,9 @@ static int rsi_sdio_host_intf_write_pkt(struct rsi_hw *adapter,
 	address = (num_blocks * block_size | (queueno << 12));
 	length  = num_blocks * block_size;
 
+	if (length > len)
+		memset((u8 *)pkt + len, 0, length - len);
+
 	status = rsi_sdio_write_register_multiple(adapter,
 						  address,
 						  (u8 *)pkt,
-- 
2.47.3

