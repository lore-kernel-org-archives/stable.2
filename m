Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B48C40D56F
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742723; cv=none; b=dZpWwfrazOnM/EQCtOz5xVbxG2dFJWcyamaiUo9AHOqBo4qji53CiMU8JRw/TDAvg3kU3s/UsXqOVSOpAUhu38tRdBUrY0/ryALtIboKATwkIyCuFHsXQttVOVDLHug7ZCm9ax88jSoCU28ks/yDID91Hg1+jpWvR5dC5/Od3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742723; c=relaxed/simple;
	bh=iSAZ4Ira8Syc91hil8DmLBWVMNQSFytiHROJ57uf+ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbQA7+OUv1wIHLRAHFeMAGDCYi2I3dexrijWk08aRZatglSfl1l4tb5XEUPEqliH/XHMlSTrHVPLO4HRM7QUWVF69hI7CWMkWNGYN38gHQCgxj0gfm3XFaja1SFMl1Q9Z/Pm/o4VFEW/OG3IYHhj0gp73NRVf9PAIsLsGlF6Zsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=kFDrDWAy; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="kFDrDWAy"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-13810b63a1aso934333c88.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742721; x=1782347521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mbv2pyuT8di3EQUSPpEAFc9iY0sdX2j90bnprBqKlTU=;
        b=kFDrDWAyQVFPGVuU+tH60nIqyJ5fVrijFewOvvbYDJYU21FhTCTme+2UoeX2zYECEb
         dra4kjewT8t52kGeG3v2upizhTP/PodksUcweAadqog+b+dayQz+t7Ep00pBNua8L8GG
         QvZLkgTDLw1ka/VqnbDwaIQBznQD7UzLvlYaL82nPhfV4R+TUTIBSWCZale3qajm/7iX
         vNDX50SKt+bWlmMgLhfa+Jkss+Xt1uqu1uJeUzzskNzNWhasCZsjb4EbesspMKSzCW9M
         psnCMNwHSoJ2tpQOVGViqe1PbrRgQqNzq7y05JYBzqVSfyYXqjS0eXhun0TN2TaeROhU
         TZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742721; x=1782347521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mbv2pyuT8di3EQUSPpEAFc9iY0sdX2j90bnprBqKlTU=;
        b=dRTbDWnko3uZSalhl5weOtOBAhbDBBmlIfsZ9gs4H+8eXv6S2bj5ZAP2qebQiPczHG
         lKf764WQsw6/X8GK20xtKbN7PHf1O9wN2u1bvJXGzBL0v4Ju2ePL6fPZ66znUmGgmIB4
         AfauT92MdBTxglJbDdmbNrLneMXXmxUKojQb1CXG9sswGnU7Z2EY6M7eSEH6e0BxZ7dl
         RDUtcaxqxQ64glinZkep5n7TueWmVw2FMu/+5NGHMZQYN3W0jQjSwK95XxhLV+KeJ9lV
         B8x8mNyXjM7OLT2zo7yKJUYS4hJc9wwfmK0sx53BteZHqYT0KnIKNs3AnktKlHQIc95y
         f6vA==
X-Gm-Message-State: AOJu0YwdybNJN7HRfhN7Oo8tP2wghj/93ReF9Y684R33moDcmQ8pklMf
	W0+aegHUXEZjPR0aSsf+ZxFiD7MJo73TkpL9rbyJBNH+GiDw3bR0OaVSW5jLP+Ia0+8=
X-Gm-Gg: Acq92OFhNAdwX8XDqDhntIMaJZ6FS6FqSE52esIeMxZURV88mp9P6Qv1G2tOKm/mQl9
	SQ4YsuKJoYvw89HMoYBTHJllUXtUKJILsEU4dlcxBVm5I7z51wR7nU5CLAsEe1HLIgisL4StyFs
	WPL8XvYl37A78eQE3DvTecB1Aam8ZJG029m0puesc8/mqqG38EEodWmNoCzn1cE4bTxsqhsXhwC
	v4235RqsFk4T5qjsPvVnaaGoRv1CKx4jmgqaiFdDjhfqmM/6OUCbGFuPfSCyBtL5ZO6OzrPDoGn
	EBfhJO/4ZzWYrajD2ZIRvB5t5xyd+YGmt30A0xd0hE0vcks9+yOm7hfXtPI/o3sBhpNgqiSPt8n
	uUuvmwF1qjH1marKLew9bgx7RCivPj4iZt0oBPp9pUQc6xfLFXBPaaUNvBPkcIhl0TDQc9n4edm
	yU6YoGDmGrF0Pu1ZjeiTU9vF0cl7np4LWClw==
X-Received: by 2002:a05:7022:ef02:b0:138:1987:7d8d with SMTP id a92af1059eb24-13999b296f4mr102760c88.18.1781742721547;
        Wed, 17 Jun 2026 17:32:01 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:32:01 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 30/38] hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read with pmbus_lock
Date: Wed, 17 Jun 2026 17:31:20 -0700
Message-ID: <20260618003128.3112824-30-abdurrahman@nexthop.ai>
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

[ Upstream commit 4e4af55aaca7f6d7673d5f9889ad0529db86a048 ]

adm1266_state_read() backs the sequencer_state debugfs entry and
issues an i2c_smbus_read_word_data(client, ADM1266_READ_STATE)
against the device without taking pmbus_lock.  pmbus_core holds
pmbus_lock around its own multi-transaction sequences (notably the
"set PAGE, then read paged register" pattern used by hwmon
attributes), so an unlocked debugfs reader can land between a PAGE
write and the subsequent paged read in another thread.  READ_STATE
itself is not paged, so it cannot corrupt PAGE in flight, but the
same defensive serialisation that applies to the GPIO accessors
applies here: any direct device access from outside pmbus_core
should be ordered with respect to pmbus_core's own.

Take pmbus_lock at the top of adm1266_state_read() via the
scope-based guard().

Fixes: ed1ff457e187 ("hwmon: (pmbus/adm1266) add debugfs for states")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260518-adm1266-gpio-fixes-v3-8-e425e4f88139@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ replaced `guard(pmbus_lock)(client)` with manual `pmbus_lock_interruptible()`/`pmbus_unlock()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 432a7088e22b..4afd10b8eea3 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -328,7 +328,12 @@ static int adm1266_state_read(struct seq_file *s, void *pdata)
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	ret = pmbus_lock_interruptible(client);
+	if (ret)
+		return ret;
+
 	ret = i2c_smbus_read_word_data(client, ADM1266_READ_STATE);
+	pmbus_unlock(client);
 	if (ret < 0)
 		return ret;
 
-- 
2.54.0

