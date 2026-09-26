Received: from mail-ua2-f42.google.com (mail-ua2-f42.google.com [74.125.226.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401093793B1
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790452737; cv=none; b=qq7eFr9gOY6IIQzBKEtcREyiFMVAld6mWQJRufb3BdFCzurgNM/hqfjLLcwYLPHz45Ke/syKhpDu2+5EDGF7QRXGBGTCOFTYWBAbl2X1NiEkpG1Zkyj1E7p9Xjb7G7+IUTofbx/X2xcI0H8luzjg3f5yF70/VVPTRHmYyRn0G7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790452737; c=relaxed/simple;
	bh=OSBsZUvrhwcSIuPOCdqNSnmPQ4GkNDnc04aQTzCNXic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwebMZ85PkQtdKaVzQpJDxy7v02TyK36tMZ3hHPHy80jstoM8gnbI3/b6uLx8o/RzMaEy0g7u9A6E/H9oQjdk/Mj8rbeQfRY8Ec00QUMRtYASGxtQFQlDWOVTvjQNh9WZnkZk4Ku5v92aPOMGxE9J2ii2da+0xfTRcuz1vuqhbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBZ4e1J+; arc=none smtp.client-ip=74.125.226.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBZ4e1J+"
Received: by mail-ua2-f42.google.com with SMTP id a1e0cc1a2514c-98729795320so119088241.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790452735; x=1791057535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oeIZwRgVz0RIdraMrjfODss1t6G6xITndUtYiEdrjvs=;
        b=oBZ4e1J+hJWrLghT3UMHZq+DBTguJR+miXWs6/eLKKbsuRnQyHkP08QOwpM62hCiWG
         EzKMEcTz//5CEyJaU101uS31TNdh6DZQPlVPfze2zGGc/ca49waIlyihIKReIYBXGMfj
         K6om+HdpeKaph+Klg9Z8PY/KMnDqBhYQw38Xr6Tk4VPJDfQATabyMqKCVLXyYdzI1ZrP
         Ir3uEUamKvuoT2nIZVPOYpPYAGD/DWTw25qf9OUSQUfbUak2HLGFW9PcUvOCa2UgMaNp
         gWUpG0MgTYTLJDEZZtB5Kb3gndvvu7SmXvMno5Jm9YLF+JvgXjKIQ2cN41WUAjWCr5Ts
         eHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790452735; x=1791057535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oeIZwRgVz0RIdraMrjfODss1t6G6xITndUtYiEdrjvs=;
        b=xmHSfXuyshcXsJRwmnPab/ZrJTqplZR2ZXLTV5pVPxA+J6OTx15J8gBTSynXYk2+tr
         7kiygYvAGNadHYFg8R4m9sIMhoNInrGmGgxc3FB9KBCnt1CoLzsbDO9tr88ezdXRI3Bh
         t02eS4K+9YnbWr5QVFSv0e8vEkB7YpoKrpUpicD2YsJHYhtf4S4yc5Nd4dAjpDgZil5K
         7vPB24NnMgaDRu4JSqWYUL2bMKt5jwhmMkr4slKp7W8UNEpvZPM2O4GWU+ztWF3fZqcK
         4wSAJDTcu+lzSTKkddV3F0TOUyVmLpH72T0tafLHZvIq4PWJIYkpOaalx8dmERT0pUEl
         u6+g==
X-Forwarded-Encrypted: i=1; AKwUvBzNliMq2rCg5xBbwSKoelcAzQQ0uCy6oEW2mMMzdOyChjDWL9FEK6gTa3cT9CjFjJzr18f+8eM=@vger.kernel.org
X-Gm-Message-State: AFuF++na4a344a9DvFzn3VQaRgHvZRClyqg9CPfDICjuMjhPfCOMnp0X
	kwHLi64HDCwm/wXdNtkVXlS2pIOImte/l0yLw3ZTaIwhqPvt80Ou6AsWR62fO4Ft
X-Gm-Gg: AYBFou17gSYuKtqB89U0Pp/sfyqvxY31ny8nphu8cXvA79Gew9TEhnW68JZwK86idZS
	qtUETpQMk/ZQ9W6AidmZENawIcCskqG5QPQ+0YS0DCOS9YAemO04OMUZOvftIZMFC6f1BtgVDS6
	wSVLZ6lmGYSxX2oS5yt9Qhlth1mhK/f5DBHkSiLwURy2lUduc3VFItS4IBrGSuoLYC2v7lNK5B3
	91cBWs4TrKHMeZfVCcShMOUT5QgV0PYYsUbEeNN6vrkckm5rckZCyiUX1EfkBxq8rVU5ueIoPLD
	SG3SqwKgzXvogpKWefwV7SviWA7SY4hbRly+yXdUTFZgKNbvP7aIM+9MKo0qSDEA5ErumNS9yVH
	M/Kag5ImQtnqdIdKBe9iYE+f7MvrwijbckDr6ETsmfFwUhrslIrb2ZokU33oN/JjAoPZljL9jiI
	JXWUMw9Mds2ecSN4DF372h64qJX4Lu85tDrI80++KjQ4SeLCaUKuRz1oiZJuOG8gSIjrAQ9ll6O
	Q==
X-Received: by 2002:a05:6102:3912:b0:7a5:9a:3a31 with SMTP id ada2fe7eead31-7af1e0ef5f1mr3624522137.34.1790452735029;
        Sat, 26 Sep 2026 12:58:55 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9861afedba5sm7437742241.8.2026.09.26.12.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 12:58:54 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: johan@kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v4 0/2] debugfs: fix UAF and double-free in debugfs_str read/write
Date: Sat, 26 Sep 2026 16:58:42 -0300
Message-ID: <20260926195844.1296333-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DLPDB44JJRGJ.3K6JNS746M71C@kernel.org>
References: <DLPDB44JJRGJ.3K6JNS746M71C@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:
  - Patch 1/2: drop GFP_ATOMIC as suggested by Danilo.  Measure the
    string length under rcu_read_lock(), allocate with GFP_KERNEL
    outside the RCU critical section, then re-read and copy with
    strscpy() under a second rcu_read_lock().  If the current string
    no longer fits the allocated buffer, retry with a PAGE_SIZE
    allocation (upper bound enforced by the write path).
  - Patch 2/2: unchanged.
  - KASAN stress testing with both fixes applied completed with 0
    reports; the concurrent-writer reproducer produces ~3900 double-free
    reports without patch 2.

Danilo also suggested introducing a struct debugfs_string with explicit
synchronization to provide callers with a proper synchronization
contract.  I agree that would address the broader API issue,
and I'd be happy to work on it as a separate follow-up series
if you think that would be useful.


v3: regenerate patches with git format-patch (v2 failed to apply).
v2: split into two patches, add Assisted-by, include KASAN splat.
v1: https://lore.kernel.org/driver-core/20260925175831.3701812-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  debugfs: fix use-after-free in debugfs_read_file_str()
  debugfs: serialize concurrent writers in debugfs_write_file_str()

 fs/debugfs/file.c | 55 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 20 deletions(-)


base-commit: 6812ce4e4379ffc99c52401ec28f0d7ffbc36206
--
2.43.0

