Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032833;
	b=0yQIcs6PfkulF4I3FvtkND5zUu5SfPeI1wfghqYWpSviS9qwdk6JLkA9cebxhXAlh+1Q
	 odgJrqHEaLY++YRJH3JwldW7owbGbunoYCrfRWntAzUDBYrpS4FQzJ1k/vAPAMQthJOKt
	 HP438JmaRUW2QHKhUg7uIPl054b8wyLeIUhkQuVOn50HVrqoxGl/ponzFdAUuupZJ7ZAZ
	 Cc0U8pBzpUrOaN1ZJTA7WJaMl7uWv1W+zdYVWWTOcOvwCtMgTVsd14x8CUX6aSojNRDee
	 hNjVgZV14q6lvI0NTuJXvoqvHQo86jgX3Q4KfxYBS+AW8NygG7KXc+93WveoQN8zBFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=k/RQfOJkIdQzlXf5l9/irF3ArAcPBHy+Vg3AaL27hnc=;
	b=p4JdbC3WfSqS3K/okfDU/YgLCiCwKnYz/rGabk85uvLiU/F2u24xV9e1TZoWeXu0/BKH
	 ylfAOHB60znxofZ0/R1FLYiU7uvwDaPGl76UsSNubfArRT3JsiOqcrAxjWNwTYj6FW2D0
	 UhAfDYwHIzLtuMjFAeBMdhP5paIZevsalM6oxOIZt3lhxV/tERkdYwwOyhI2tbaab1q+h
	 mdruRjthrSoOq0O6NDJPT1Jh9T+YlKk/DYXxGzKU/7sc440C2eGgLcEsmBUN5LciikKGH
	 pq9Dwv1bQ+HDZAiiPK7VbizbJgqed9ExgfMiHdqZ7AD9wH05cH00ViXy9oFL07EdNIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=neat.no;
	spf=pass smtp.mailfrom=neat.no;
	dkim=pass header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=BGxxdXgD;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34724606A323
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34724606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neat.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neat.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=BGxxdXgD
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso15392895e9.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neat.no; s=google; t=1793032832; x=1793637632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k/RQfOJkIdQzlXf5l9/irF3ArAcPBHy+Vg3AaL27hnc=;
        b=BGxxdXgDu7POvfZH79dO8OlxCieEAJvWevRnD3N3jX5J5o9BQbrBCwe7mBl9UYWT8T
         XE/0E7TGAosTwDwNfTd8StOQ4yNU90Q0jC3qUIdTP4qeOFa/g4J2+W0zLLejdoFOlB++
         slEHrehG+9izOCqVFBTL9lV67hpYQd+JZj2Fu+Pl48yZwHOhK8hoJE0XivJG+1vB2Efr
         upvLmA/0oGTT/OjFzvcu+jZLrsLw7VnFyA/Kfc65wMPXfqntS0cRElo7FTMGqX/DSv2a
         ck240wqEuxrqEyrz5dfE/ivebO8noNxg45WukCJx2/wRgV/7g0WTV6AidSAMA/ZAHjT9
         hekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032832; x=1793637632;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k/RQfOJkIdQzlXf5l9/irF3ArAcPBHy+Vg3AaL27hnc=;
        b=Est9UsIVURwfeuP4Flk9dJ24VveQ4J5Z2DhzvajJFFsIB8gdHlHwQ37WyblFmXJlLG
         +wDw97KCqWbN7uYuLCt/SqXH+AdKNxmbqW0j+JPlt9LTsx7LW0WiX0Y4CrZknrzNYaay
         Ripy+Hl8vLPMiCY4DRbtiwKz5bEdTJCQ0oL25ke5q/lylB7+4bToeutf8hlb4LkUqai7
         E0XmeT+3i1e/qIiLPgWekPLU7Nupc5pyXU2LpLpqahhd9t4ZCjNyfHpRa6y4WF6Q+3KT
         NnuiQQIJHJ1YElQntYfAgNsVbc5m3SbWEN/djJnPdZPE0Cs+F6ImHaYTx5ZydZOf6lKx
         YEtw==
X-Forwarded-Encrypted: i=1; AKwUvByKrncG7qHJV73gW60XK20F01XIocl+jfZfqeoCT+BiLcfR+ITY0iB9PD91UBYde28NEQSA+KA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+wdw9lJSS1aNYXVjAn0MRzJKuuCr1p+Ot1klDHvH9CtTg2e+K
	ELi8MlhDPM52gFhvR8/EOYNWZiTNnJpmSXLk95ruCEGr5z4K/gno6IbNaLiHEu9Ok1FZ9JiEtj+
	8g5sznaDNdB3y+vtTAPlFHuMrCuWRa0CizqsB8yLuaFTfRcl4emDsLK3iFNGxQdfc+/ZOZz3Vg9
	QZmmD2+2e8kXjfRjqbo7tZyVwR2PFlF9eAaNdamWHABjSQdZZElZgDLVHmcKmmTVW7cWSKmpHOy
	os=
X-Gm-Gg: AYBFou1ChkMCtNocrvKhAOsceQxG3Co4m8hqU2hYg/7TpOzlggPH0C4vfORVad809zQ
	RszRU2IJy8TZoZQmxYZWYfRyG8I8myaPZt7LfU8GJDymidjuzoDgcWQOOto509yXUuuGXUF8ZYx
	3s9X/sZeAoCfw2VCmHA2KHCbxJbPnSe+te6SxlYguWwlEqTCFfjDQtvz5JdAh4KLlfKkP32Ixjs
	qh9LCmutJ0ufM7v5buzapLA4yiUrGxE4VO1EMMLhrjI4B1O4CXkNYywggULi9WSG5xFjoscoVlJ
	2HxKYcltPH9DN+Oka8Pm9BRb3uDOn4KAF7v/AUogeqnJ6U8kXe/pd5NeD1aWIOw6wmqmAGR8LhN
	lTUdFUR0XSbffMzkz4QbqE1HIkXqVZRJ5NCmfYUa3i/WmC7zaMn+oRv7yanZXsKPCckxGM6LJvm
	7soTe7i7lppSoGU+v/+Gcg/LEdr78+0Sjfr2yJ737MI6s2VZ5PAOMfAFKd7DphaAsib1DE8zxIZ
	x67UUE4Ao6gsKb4et2qwkZnlUqz6HY2u/MvbQrrci4pS+RGPo17RbbeEoed4pG7
X-Received: by 2002:a05:600c:811a:b0:4a7:a309:6b73 with SMTP id 5b1f17b1804b1-4a7a3096bb7mr12028775e9.1.1793032831444;
        Mon, 26 Oct 2026 09:40:31 -0700 (PDT)
Received: from threads.localdomain ([81.79.62.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a30e22csm205961655e9.2.2026.10.26.09.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:40:31 -0700 (PDT)
From: Lucas Tanure <lucas.tanure@neat.no>
To: Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Dom Cobley <popcornmix@gmail.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] drm/vc4: hdmi: always cancel the scrambling work synchronously
Date: Mon, 26 Oct 2026 16:40:27 +0000
Message-ID: <20261026164028.78792-3-lucas.tanure@neat.no>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026164028.78792-1-lucas.tanure@neat.no>
References: <20261026164028.78792-1-lucas.tanure@neat.no>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The scrambling work re-arms itself every second while a scrambled mode
is active. When the output is disabled, the work may be executing at
that moment rather than pending, and delayed_work_pending() is then
false, so the cancel is skipped. The running instance finishes after
the disable, sees the sink report scrambling off, writes the SCDC
scrambling and clock ratio bits back on, and queues itself again. The
sink is left configured for a scrambled 1/40 link that no longer exists
and the work keeps running until the next enable.

cancel_delayed_work_sync() handles both states: it waits for a running
instance and blocks it from queueing itself again.

Fixes: 257d36d493e9 ("drm/vc4: hdmi: Add a workqueue to set scrambling")
Assisted-by: LLM
Signed-off-by: Lucas Tanure <lucas.tanure@neat.no>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 2cc46036f11d..4a386e053d3f 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -843,8 +843,7 @@ static void vc4_hdmi_disable_scrambling(struct drm_encoder *encoder)
 
 	vc4_hdmi->scdc_enabled = false;
 
-	if (delayed_work_pending(&vc4_hdmi->scrambling_work))
-		cancel_delayed_work_sync(&vc4_hdmi->scrambling_work);
+	cancel_delayed_work_sync(&vc4_hdmi->scrambling_work);
 
 	if (!drm_dev_enter(drm, &idx))
 		return;
-- 
2.56.0

