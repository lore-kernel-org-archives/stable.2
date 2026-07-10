Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B102BE656
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650564; cv=none; b=g894PBJ/kUBUU1YdfYujvEFvhfj3xtBqIzu1JKrn5QEHjTrNPbBBAUjQyREg4Sn/3rwK7dalBH2+e8a6luDRLvk9+v0lDWzHwhtSNhYvB8c6FzgTgK0s3Z4lqlbix6/cfe5ey7VWCsSwSNC+S8tnBivQWXEnlLzAzCVt9ZyGj3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650564; c=relaxed/simple;
	bh=wsHM+8ZeYOqCJwA/6tpF0q5nafYPW3zlwHQ3/xAjE6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxjhOroP1+fsW6nWroncPoeE4bsxtiH667vdFpSoH7xLeaBoOshBP4DPu81gKFQ+ACyDsJwqjrFk4TgQPHqsdcxLmsmmXh5CpsBvD52cDCvvWiwDPlHjr8IyfJbU0VH/PnwYGKmeSvIx4OZS7Xpbir/GbA3lDDdgvsYG5CcBuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqTrvVUn; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqTrvVUn"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e5d6f35c1so33562185a.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650561; x=1784255361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+VrbOIz5DjpeTHI1zJiQK8GMybM0cRVGEIt9+g4I/iE=;
        b=PqTrvVUnaBupsH9/QjAjP4yHzhxlVYCizcAWeVJiLKUwDa+QaHD0BZEI2Qj2Nv4yGT
         I13FnCkxM62jIQjX/afy9CVWI/6DfGcKmTTkFRGl3G31QaJiJPEbDnqSvZCRpEeq0sdc
         w32G2e+JKcK23ix6mszoA3P2TVXp/SmtOjMjW6nJqJvXz1aQVOQ4IrrA5WtUw+sGESnA
         gpbVTI6HSQ+/wT0iyl3SFl6CQG4ssvyepaZM9VLy2xwpdUkEKhnDl0fghcRQ7KYn1hNu
         pdC3RxvdM+6xk8xK0QYvp769oFrUfQvHE4YfNtNNyZYzukoomhZFnMTwQqt8SqjjpU4L
         Fb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650561; x=1784255361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+VrbOIz5DjpeTHI1zJiQK8GMybM0cRVGEIt9+g4I/iE=;
        b=nDQ/DTrqj0M8dataskHtIvvqfDgLsvSvlzrFzAxJvUw1waCQ3kqsq6ftF6/eEUBd0T
         jq/sbJtvR1ZHBcVuYZfMb4i4hlK1QPKMxX3HuaINTFRCueVcbJkTnaHaV8DnIhVT98IO
         qnXxixv1+zEuVJ/otN/g9QleyC2wa18La5e6py8mGyp/nFU3cjNScDdz6fMiqYOK3/Pb
         fGkVImHpw2mAcdxFZDRgaa/C5mVR5NT7ifRrPoODpZEzPNmIprNtNWIk/C5naw5JSGWa
         9fL1iQ0rP6X/8AIE3OoWylDakvlS+LTYKWrjuJPFF4/WzPLzLSaQL3bHgCUiKM2JjVka
         +Czg==
X-Forwarded-Encrypted: i=1; AHgh+RqoenEsfqhBwhCHgVF8to7pUoaO9QcHBzdIiW3tkjE8bbdN21ZzYdxqI+Y8fa2x7UAsMc5boDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjVthFqUuv9XsxHTG34beN59T1ZqQEaRgDAUxmdYUHdnPVIY0
	igbNQV5sX+TK3Ai9ef1EO3N6LDMdFQVaEWVp69SNjY6ATExqzdQ34iYp
X-Gm-Gg: AfdE7cmoGnJ2MJiaJvodp4yzB2XuJ7atUwPJ/lsQHP9gEUnP8ztvACrevlhNsYnpMG4
	DjQ5Um/gwcDBkrHGPrQe0zEkHmWlILCpFkEZkFEqpzotjF1jeZgfwq0UjTDoUpBgoDkwtQGp4p8
	RoVgZbYHy+j8Y1g6I3k+RU8JAlqv/Yr2y1mmEm8tTAVSOokC3H0xsbOrVp+epz7Sute79pmmeKX
	cuYQ2DVJmvGzqv5ahPyYqDG9C5Q92S8IQUkmLVQt9tJQBZul0tGTU+/3XwMNEv6dLxDfhqlrENM
	fLXOdyjsbAPTm9Iv/YjhiDLDs8e6mSKPAIy2snFc6oBwVsSDDOoply8dyvBUSsVyTwF+j0P8S0q
	pusFTxaW2cKXZmLaIr8bFF3p45j8PtiTzw2zk7MKvRlccOivAOg/74nRu1Ilh2btvbra4Xf8aJ+
	AMOPmfGt66IAZJa0vaXW0YhQW5d8kBZObtsewY4McmkHkjz1stYsZREmTP1sjfyWDIyadAw9aYY
	8sER/euSCYRjL5+LTKHEeMQRkVyzseE
X-Received: by 2002:a05:620a:170e:b0:92e:5a74:962e with SMTP id af79cd13be357-92ecf8f520bmr1013173385a.62.1783650560868;
        Thu, 09 Jul 2026 19:29:20 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61fb9sm86411685a.41.2026.07.09.19.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:29:20 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: kys@microsoft.com,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] hv: hv_balloon: validate unballoon range count
Date: Thu,  9 Jul 2026 22:29:14 -0400
Message-ID: <20260710022914.3740453-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The Hyper-V dynamic memory host supplies DM_UNBALLOON_REQUEST messages
with a header size and a range_count field. balloon_down() trusts
range_count and walks req->range_array without checking that the received
message contains that many ranges.

A malformed host or backend message can therefore make the guest read
past the received VMBus packet while freeing balloon ranges. Validate the
received message size and reject range_count values that exceed the
present range array before walking it.

Impact: A malicious Hyper-V host or backend can crash a guest by sending
a short unballoon request with an oversized range_count.

Fixes: 9aa8b50b2b3d ("Drivers: hv: Add Hyper-V balloon driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/hv/hv_balloon.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index a848400a59a2d..f5bc8c9fea7b9 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1337,8 +1337,23 @@ static void balloon_up(struct work_struct *dummy)
 	}
 }
 
+static bool unballoon_request_valid(struct dm_unballoon_request *req,
+				    u32 msg_size)
+{
+	u32 max_ranges;
+
+	if (msg_size < sizeof(*req) || req->hdr.size < sizeof(*req) ||
+	    req->hdr.size > msg_size)
+		return false;
+
+	max_ranges = (req->hdr.size - sizeof(*req)) /
+		     sizeof(req->range_array[0]);
+
+	return req->range_count <= max_ranges;
+}
+
 static void balloon_down(struct hv_dynmem_device *dm,
-			 struct dm_unballoon_request *req)
+			 struct dm_unballoon_request *req, u32 msg_size)
 {
 	union dm_mem_page_range *range_array = req->range_array;
 	int range_count = req->range_count;
@@ -1346,6 +1361,12 @@ static void balloon_down(struct hv_dynmem_device *dm,
 	int i;
 	unsigned int prev_pages_ballooned = dm->num_pages_ballooned;
 
+	if (!unballoon_request_valid(req, msg_size)) {
+		pr_warn_ratelimited("Invalid unballoon request: size %u, header size %u, range count %u\n",
+				    msg_size, req->hdr.size, req->range_count);
+		return;
+	}
+
 	for (i = 0; i < range_count; i++) {
 		free_balloon_pages(dm, &range_array[i]);
 		complete(&dm_device.config_event);
@@ -1527,7 +1548,8 @@ static void balloon_onchannelcallback(void *context)
 
 			dm->state = DM_BALLOON_DOWN;
 			balloon_down(dm,
-				     (struct dm_unballoon_request *)recv_buffer);
+				     (struct dm_unballoon_request *)recv_buffer,
+				     recvlen);
 			break;
 
 		case DM_MEM_HOT_ADD_REQUEST:
-- 
2.53.0
