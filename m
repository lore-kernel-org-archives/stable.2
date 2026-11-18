Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999766;
	b=suNPq14JoH12edP9pQIfa6/O1vSdJ2nR706lxOxC/sNUEp32jp7yVW+TWqr10hmoRqAy
	 fTkgqkk95HM5iQlZFNc25O8GOx8MtcIOrJdJ6K/p28/PDQeP9K4JPcAZXChmiv62lAIC2
	 IHhvVoN+YbpkJ9xkIC9BqugNJ/Ts3gL01ZLpWZisH0+/hIy/j+1xlqVbj/qZQr2lmAC2L
	 BU5fewCXhctE6yYROgOKYEZlmWoqGb+OV7mJddp1//0yWY8YSSntVuxMca5UFW9Pexuzq
	 ZYSCyYZfYk+KOo1SjfGAvSz+BNVCP8bdQP8+wBUWM6ZYxml3VddxWFXhFQW3Rz0CN2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SqV4Jv6wNfUGVd/YP57RFpsT3eJh+v6vOgo/2e6RqII=;
	b=CYtEinAmMxwoFbuTAojoVcDoPCP79+IOxeu4xkwzlpLZ1RQtULH3pjGEkAI3kdHPkQbT
	 LeReRzWOx3CHbpBAiyPQ8QeyxsV83Sa4dK8iQ/pwcXbPxy7S5XwdiV8UfJK3rROIVZjXi
	 NGAB53bOXxZxHLMD0LWoY8R2Zbql8EPdiBEElVcudEQ5Mkbd+gd/oJc4HI8AA79+hUoHV
	 +k3jIK4vRBApYzh8V9in4/GAkZ1qmK68/MzhgNWVsbqcsXyzCTbsxfT9/kv+Yilc0rNNP
	 v2DRkD4HXrpSWFUHMjs7rMDy+eLwEAph7UJZZoBQjJAnqrZzTn0pPjoKoCHiJq1eAJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvz.org;
	spf=pass smtp.mailfrom=openvz.org;
	dkim=pass header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=c1Nip5xs;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A5606A33F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B2A5606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=c1Nip5xs
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so8572205e9.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1794999765; x=1795604565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqV4Jv6wNfUGVd/YP57RFpsT3eJh+v6vOgo/2e6RqII=;
        b=c1Nip5xsyTHC0xGWwW3Bb2WmpVhPiD3B24SZrfsIxPhHbI4aIKmUngZA/nkDZ97KXq
         rvK3wYysqPwFB+RsrPMtRHpCjwEsFbvCxHEqjSYPOfz2UXfBTtOiOW0Ujn0aNsjohLJr
         3x68RfmSjhC/MS0zdU4CcqaUksM1VHcBjPV6MQNb3BZ1lyJkxrcjnM/UA7TAdvSr+bJi
         MdocO7/j90Yq6+LSQyrCWuVo7nGAH+ZMoYTtN/6w+M6Rmybk2UE1k7PVnhDTg+BOZ2Am
         mVDeZhiX+A2jN9DRCTyXerZG2fcD71dUck6FdGmeXmUxhgbl9trxFGcdptmF1dqM+T3x
         uZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794999765; x=1795604565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SqV4Jv6wNfUGVd/YP57RFpsT3eJh+v6vOgo/2e6RqII=;
        b=ptM8995hdqEmqPKe4vLA1F/A3hN5yWayUNcGYjSB8/r+mseFZUWjYasuYEniUeWJEy
         frzaFNnwfM/4UgAIGYCRZ1dVa3XsOL1wvjOmYQ4G0ojOlhpbMBiy00gLuxxBTs+tMdzA
         KluIIgRYnHezaJcn8obfBQAPLKLPSExkEU80Xab7oU+mfBquZPKXMN0t98wAitvFgfpF
         CUq+cVW7t0kgtLYkVNHLJrmIWvj8fjhwY/riapue6SmC3OY3dQ1YcT/yziWkNtrHcFri
         reqkaa173AcOjd4Zxa6ouVyDb4jytsARAiCmCudfvuX5c9oRootOTigV28yJspWP6bYn
         vlAg==
X-Forwarded-Encrypted: i=1; AL+hErGeW8PRJVN5yJMrYJSN9vL08O8kJPlHv5wclF+El6B19+7DWrWmfkkMVImr1AkGGzFhtoIXUQ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bWsAk9Of3iv5SPcWwJ8TL88XFHQRskqchdqw3OARIM7a101tr
	T09ewEwzTS5U/yXk2mtEbxwxboSTuDDsrkh0XNdrgmifuY4dAob2xi/AZ8oHUbXY51I=
X-Gm-Gg: AYBFou0VuIrb3Gaik2l2BQvTYPRA4J+nlWPio4bOvmkxD5GlixZFIZcVMmFOIBH3jLN
	M/c5a9fpSbYZLyzdXah1hYJwx3rNMWP5CgJ8zXBpZj7HV0wMMcf5esAiEkcGzpoPP24EhfJv8NC
	m6rskaIzlfFB7gROSABZ3QJh2QPWTCQDkjyDLk+W3LYW7JrTpTHa0ktE4IPe7hoQbbIzYxAyhVf
	OnQYvyiFKtf0TNmSuryNks6Z1vI1VxMyScvNFEwyjFpqhbhaV0x6yVXet+UgZdrM4OjSVT1GMvD
	EOQxziDAp/wMDP05vdzHzGyLOfGTGz/Sf3Wg/JCw1Koqz/9GPtybe0sAmkDVYQpbX3ucMfV/Rxf
	7dgPS5bMVsHrqlTD44CcHNnIGwHRptu4bovDukWd2LkV/9NdgCy5cssjDAGtt+WKnsyM3xHNmKk
	uf3si/69AAlFZvBfxG9Zy8+ruUJ5mcj6QjYIzXXCi49nSag93Q8XQ90aVWC0cM1rf4KfLEs45va
	tbCFhnCKdZN3ampxwqt1ETh3dCSwsQ4kdSClxFCfnkGK18agc+TByqFWMFNE/9YivAZsedbyh2P
	nRy4kW66oa3x3DVrADrodKqsRmvw
X-Received: by 2002:a05:600c:3b8b:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb7da1b581mr53254625e9.13.1794999764776;
        Wed, 18 Nov 2026 03:02:44 -0800 (PST)
Received: from artemis.sw.ru ([2a06:5b06:b600:300:8c09:3cc3:6efa:ac1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm3943277f8f.52.2026.11.18.03.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:02:44 -0800 (PST)
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
Subject: [PATCH 2/3] dm era: refuse metadata rpcs once the target is suspended
Date: Wed, 18 Nov 2026 12:02:38 +0100
Message-ID: <20261118110239.2910290-3-den@openvz.org>
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

An rpc reaches the worker in two steps: the caller puts it on the rpc
list, then wake_worker() queues the work unless the target is
suspended. stop_worker() raises that flag and drains the workqueue with
no ordering against either step, so an rpc can land on both sides of
the drain.

An rpc queued before the flag is raised, whose wake_worker() runs after
it, is never served. The caller waits for a completion that only the
next resume can deliver, and it waits holding the table srcu, so a
reload blocks in dm_swap_table() and the device can no longer be
reloaded or removed.

An rpc whose wake_worker() read the flag as clear can instead queue the
work after drain_workqueue() has returned. The worker then commits the
metadata beside the commit era_postsuspend() runs in its own thread.
Both commits allocate from the same space map and take the same block,
which corrupts it, and every commit after that fails:

  device-mapper: space map common: unable to decrement block
  device-mapper: era: metadata_commit: pre commit failed

Add the rpc and queue the work under the rpc lock, take that lock to
raise the flag, and refuse an rpc that arrives once it is raised. An
rpc that made it onto the list is then queued before the drain waits
for it.

Userspace sees one change. A status query on a suspended era device
used to block until the device was resumed, and now reports the target
in error.

Fixes: eec40579d848 ("dm: add era target")
Cc: stable@vger.kernel.org
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 drivers/md/dm-era-target.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index ea499adca4ce..29b0602e7849 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1389,10 +1389,14 @@ static int perform_rpc(struct era *era, struct rpc *rpc)
 	init_completion(&rpc->complete);
 
 	spin_lock(&era->rpc_lock);
+	if (atomic_read(&era->suspended)) {
+		spin_unlock(&era->rpc_lock);
+		return -EBUSY;
+	}
 	list_add(&rpc->list, &era->rpc_calls);
+	queue_work(era->wq, &era->worker);
 	spin_unlock(&era->rpc_lock);
 
-	wake_worker(era);
 	wait_for_completion(&rpc->complete);
 
 	return rpc->result;
@@ -1427,7 +1431,10 @@ static void start_worker(struct era *era)
 
 static void stop_worker(struct era *era)
 {
+	spin_lock(&era->rpc_lock);
 	atomic_set(&era->suspended, 1);
+	spin_unlock(&era->rpc_lock);
+
 	drain_workqueue(era->wq);
 }
 
-- 
2.55.0

