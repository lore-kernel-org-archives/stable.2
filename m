Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999768;
	b=04Rx/51RjekHTyaeNRUnqkrREu+2GcMoTe8KFQ7zmzbjIu/unDo7oG32ZA/c1kthZKRD
	 B46uAGxXkOS23QhtyHwci721QB3Lsrayvqnx1lHywjhYYaaYT8w+v4kHY3dW8GK3EeWI/
	 1jvkbADRBqbEBLBb4/hUFsAr4M4n7lAALrK7QIe4vFwoEwAswQ1CCfGlcojHJZHUZcxfz
	 B4yZkGny0xHffoWUO/kLtpl+zfI0FzPK2sjh3IPSAc3WZeiWi9FhpkabGUnIFhzoW9RNu
	 BSVt8P07O+qaAmpOXtDpan9aDYtVpQ4pVe8Cezts9MBUFE5atVzp4K1yK2A1Jxlf20A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aaVCz9shF8ZFyzO5/5N6GKpW3bexM2Ih05SHuYmSwNk=;
	b=Z+t1h4pII0RCcxi6HoxZla8nqEy61lQXQ0cRiRRNsLmr7aU9QSMCiwEcPHoSHcvg2EmW
	 CMxGow25+i2SWYfalivyRcuoc3aFsrxeRathZxPdgwuFXyIgk8X283cfP+1Qidhuc7rOX
	 IEAStMxzqj5tA9xHBJalK4W4deiXIQi33UbseMI4UORg/aL/DBAUL9Lfy2F2E0O2IUQkr
	 wf1QHxlktBbE/Esw204sIAn8txJ99h9kn7s4L+raGTE5tnl34deMVrKzRuFeU38MnnvhJ
	 UURErl7EaMh2NBuMQYdj607eVwb69ecQ54R502EbgoD3hygFxeORiBJy9A415obSNhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvz.org;
	spf=pass smtp.mailfrom=openvz.org;
	dkim=pass header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=n219RArY;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962660A2619
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B962660A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=n219RArY
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso328118f8f.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1794999766; x=1795604566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aaVCz9shF8ZFyzO5/5N6GKpW3bexM2Ih05SHuYmSwNk=;
        b=n219RArYjaYdvkIMwO9ir3M3eWTlY0YtYTxXjc0cqfUMh5PydaRebzWDnFAhRA1xEg
         4vBuLRpcbhklUVXM0RpBGXT2IFnZI7oiu+3c0j1/JKIEzJ8aOelpykadn7HDCLqescXV
         5I82zgZQO6UKKFmspRCUvQYMeGeRnlwgZx79dSNJZF4L41/nrxTRt0ZmlgTS8tj/97E7
         QqMIZBAKLnaIDFfYN0ssze5vBs2ONVuUThN0JIAb5huBu0Qc2KcEsfGIXGYY7+0Z6VzS
         3HE3sEmEsj3aKjr7T6DTbvn+hkEI2Y/lpVf3oC1QZCdrp8Y25vY2hb01mJPELcfB1EBi
         w8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794999766; x=1795604566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aaVCz9shF8ZFyzO5/5N6GKpW3bexM2Ih05SHuYmSwNk=;
        b=jBxHkGwmpoghpEPaH4XyxBu5EqIskO4WELEK+9bWOpasLkKMz45ylghBk29YaODXaF
         l9Y/JAkxQzqoO4lxJNtg1F6ZefKuP0NpcHxVTf1jkMl8aRa/SC76zM+Kx6er2OSVGpmf
         BOe31QxefIpLW1KWN+8bVfm9g0NbpaNc20gHKgsOB+ZXKV9M/0z69hf13f4kHroOTsVA
         EuJ/qLGVym6p6Vz3acXhn2iLvjG1mdx5vfWQe4j5yZfCtIH1Fz4oQuktR/vskSjIpU+1
         T+EGHy5v/iQDzod0z9ByzH159g3p3S25ptcePJBzEfTRFftFUKS54QmCekHX56sqMYpq
         lA+w==
X-Forwarded-Encrypted: i=1; AL+hErHGd1u/4c9nsg+ZIGHrpCB73YOfu+mhYl6s859O9rAQ+JooXkMRZVQXhAWsBEd8u+aGYAuA2Do=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3BjxwdQDQxkQpfnFoWIjEoICjajGWHpzF7ve6AVtHz8Htgti2
	jI09DjCPz2ePuc60psHR3VT6zKwNOOJ53Gq/9VsHg1TLwNIWxa2dr/ah2Zexv80fI0w=
X-Gm-Gg: AZFdTZedSkMf3ylIfCEJZLuZKoce285hEJzRE4AiwYU+AkvlqRFaMMPRvlW+0WzTHaX
	bJL1z9KA+wg/vKfzaq39A1J6h9OnUcbFpk5/nUTqGK2weN+Jtw0wBEEugBSGFkZE/O+wRrIovfV
	xEwQJDiXk2iZi4UiRGQyYgI0QVCWbqAdZLNF+4RvOafZULv23FDqEADTOIS1Rvna7st/j9IlTx5
	+xdLJlA0gzfsliAIgrtvCJe8Pf7zsp9UVSbVTaHXHueof+gAX6ggwX+R10zpbg+5kFMI+11Q31d
	SMgkhrzlwDDY3ACn0coqlrcCdK6WeZ81P2nd54+TqrT5ARFy0wllv+TQsHTzdIWey0SpQW/6WHa
	qCjXkqRMrAJnjFNf6Dp1isaqSQpLNfYKRosYQo9szAs4+2y7SGBsr0Aa309ZUUKQ6uve+wQFwXA
	B9ssWwB2K7CRxY4rmvUCvKW+zy/peSM6/6KpOqBR6OhecWp3jihK+AOPZakzyGC/b+y7cS9YhBP
	K3RhWbuAhkN/CE/gw6nDQ5Am/55RdX8TL1siMyiRVrBP+ztyLR8HyuqUBEwHni3dfNuZRkxLl0Q
	QvrQgM/153YKDwZv4l1IkxYmDDw=
X-Received: by 2002:a05:6000:40ce:b0:4a4:6669:7f9 with SMTP id ffacd0b85a97d-4a63cd0f053mr5455559f8f.49.1794999765938;
        Wed, 18 Nov 2026 03:02:45 -0800 (PST)
Received: from artemis.sw.ru ([2a06:5b06:b600:300:8c09:3cc3:6efa:ac1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm3943277f8f.52.2026.11.18.03.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:02:45 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev
Cc: bmarzins@redhat.com,
	thornber@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	den@openvz.org
Subject: [PATCH 3/3] dm era: construct the target suspended
Date: Wed, 18 Nov 2026 12:02:39 +0100
Message-ID: <20261118110239.2910290-4-den@openvz.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118110239.2910290-1-den@openvz.org>
References: <20261118110239.2910290-1-den@openvz.org>
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

From: Denis V. Lunev <den@openvz.org>

era_preresume() resizes the era array and commits the metadata in the
thread that resumes the device, and starts the worker only once that is
done. That is safe only while the worker cannot run, and nothing makes
it so: struct era is zeroed, so era->suspended reads as running from
the moment the target is constructed, and an rpc arriving before the
resume wakes the worker alongside the resize. Both allocate from the
same space map and take the same metadata block, which corrupts it:

 device-mapper: block manager: validator mismatch (old=array vs new=index)
 device-mapper: space map common: unable to decrement block
 device-mapper: era: metadata_commit: pre commit failed

Every commit after that fails the same way, the target reports "era
Error", and the writes it tracks fail, which takes the workload's
filesystem read-only.

Userspace gets there without trying. multipathd asks every
device-mapper target appearing on the node for its status, over its own
uevent socket, to learn whether the target is a multipath map, so a
target is asked exactly while it resumes.

Mark the target suspended when it is constructed, which is the state
start_worker() already assumes it is leaving. The resize and the commit
then run with the worker held back, as they must, and a status query in
that window is refused rather than served beside them.

Fixes: cca2c6aebe86 ("dm era: only resize metadata in preresume")
Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 drivers/md/dm-era-target.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index 29b0602e7849..d40a98169b04 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1557,6 +1557,7 @@ static int era_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	spin_lock_init(&era->rpc_lock);
 	INIT_LIST_HEAD(&era->rpc_calls);
+	atomic_set(&era->suspended, 1);
 
 	ti->private = era;
 	ti->num_flush_bios = 1;
-- 
2.55.0

