Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03395448B2
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170405; cv=none; b=S/gi9UkYk2WDZJ9drFc4YSEJsF0UqgWCyblYwBTkUPTaoys5uiqrM+Xd5A/BT9diZGbgG5gI1YbBhg7qwMhdvjJQxLR85MQaetTGLR5pz2Fr9tX6wdFj55IAqDWWgwC4aytsAW6z7rUxjfqQjXMBrvX54m02yjEg8S2MF5RrlYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170405; c=relaxed/simple;
	bh=jBWZwIMiOxyxYojRsXD6S4nvuQkHBu+rSMXSXxQ5PZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MsMwOg7ngXjsUAuc7N0Qnm2DliGXLd11Or4UrpoJIuQeIVvTMUP6+Ga9KEoL16+TQr8DT+Jl2NEzflHrU5bRbNULEO8yKRi9qtiB7w7W6ux/7bDzATtG0iBTcvQ4g67Il/OXNTIn/BHc/s9TurXVrSbM6aNC9BTCClym6qzNeqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okRFUC9a; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okRFUC9a"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso187354eec.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792170402; x=1792775202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gl1azP5WKss8k1lh9wXiZ7oCRnOGPPksswe4Q0rIdDg=;
        b=okRFUC9aYG6Qz37SVSCvJDn1mV25j1sTnenL1GEtSwRJX5foGTU54BDlWzEqM7RBDK
         M34/3s3smRzjVHKzlqyZC5/Fsv3qKVXltWO5KztHqhclRjNmTZ1pQBFlzSOIQsGszorm
         RvJJluIHmS/HoyySL9TidEzz//YJFPxWOLKenIo1DGj2a9TlBGXEdnbycusbAPvrAgpe
         HVlYNZ359sD9I5dKZx0PH2ZSAZuaPVDpRocXc8OH2l8+PDdp6FGm8VaL9R+CgCu0Rsfk
         +5uUzVUD5r/I9M0MAMD+vXfp6Kgd3qMG0x8BtePbgOCAXJMLhGAm2LlR9i60gS7E4Ssh
         4PUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170402; x=1792775202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gl1azP5WKss8k1lh9wXiZ7oCRnOGPPksswe4Q0rIdDg=;
        b=oB1GomJP8qqFFHaevRr1QwddTPhnCaBQ8kmLLa/MTWUYQDdT9P5V088pmqobaWENK3
         aMs+2wWk44VFUkV4aOwcQDdnuSJ7Q916Ycca45wlqKn394EGYxwS7/fKAdVJJt/Lt2kb
         dPn3I6geL9dVDBqP2JM0GUoryUnHa0HmMMSRe6/CCzUWkseXeo7SyGQRdBw1cThk+BJK
         J0Z0KkeoigPkqFinxlDz5nHndoEmfe6Sx9Uhco8vjVZcKI38GjgB+G+4eKobS62LSSC9
         u9WwD0JXFc+sgDZHg+1nmCfZ5Vwf+zqWj/Ksd9/OWdOyJQc0Y1Lt9ZmcFOuw/Fj8c28N
         PoMg==
X-Forwarded-Encrypted: i=1; AKwUvBwsuB0v2/hLbLZXifjOKdH2p0/8nUmzBKh7Cn6l8m3h0+v/5PrJKJrzg4+wrnYnlym837+3zcE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZ+g+dF7kXj9K/vbsP9Lsm+NJpbew8h/lHXW2q+WPl2n8KIGzA
	onrD9qKiM8X2JEzTIqa5jesf4KzQN/UZ26Mar/iLSGuNC0c+KzmBn65Y
X-Gm-Gg: AYBFou19C/ZFKJJWs2sq8siEhw4kHZZ0lVuIRXqjfeLEdQFvw1HNU5epleqDuH/HD6u
	3ktRvgxlLUjLpa0eNVthrSK6dWjsrxfyFZ+Ih6ExTTa2SkgS6lsvXSSdpoQ2CvvjvcxEZzjtmgg
	o796032OzQfucYIc9Xaeqvgb87LGmIQPwaHBOQrg+1rDhYJDSH3YyS57mIcrF4INetAhHL5ctzq
	pdnnTlx0wy9LOk/+tSkX6qSXxe+JjSyn5hDEPmWwvozBX5jCe5oOpK9XwddB5paX287W36IAGPj
	Lh5d1FVCj8wVwjmtiBmLuNv5Pdgev0VTgTiU/+0/3VQS6oYUbCEvnMnN7XkCv7ZiQb0SSrET4hE
	WOGLh7r7jEOJnPRvYeUhZoiIaBOYYsFdaf26HTSI2xQD5/XP0AxoIbamsp7vGTkCUTAPbrpqUjO
	LGJBumZSqsdZQu9pYmuGlKplxiVHA8YdqPmQ0p39H/y+qVIhOxUrVkV5UR5F7N
X-Received: by 2002:a05:701b:4291:10b0:166:9e0d:3b56 with SMTP id a92af1059eb24-18513e7c690mr599794c88.38.1792170401713;
        Fri, 16 Oct 2026 10:06:41 -0700 (PDT)
Received: from adriano ([186.40.6.142])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f58c2sm11285825c88.11.2026.10.16.10.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:06:41 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: Nguyen Duy Nhat Anh <neganhat@gmail.com>,
	ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] ecryptfs: reject short encrypted key payloads
Date: Fri, 16 Oct 2026 14:06:32 -0300
Message-ID: <20261016170633.1415240-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject payloads too short to hold a struct ecryptfs_auth_tok,
as a key created with a non-ecryptfs format is shorter than
the struct, so the payload gets dereferenced past its end.

Fixes: 1252cc3b232e ("eCryptfs: added support for the encrypted key type")
Cc: <stable@vger.kernel.org>
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes in v3:
- Split the v2 patch.
- Remove Nguyen Duy Nhat Anh change and its Reported-by tag.

Changes in v2:
- Add Reported-by tag.

 fs/ecryptfs/ecryptfs_kernel.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 58165928ed1e..d4fef71738b0 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -88,6 +88,9 @@ ecryptfs_get_encrypted_key_payload_data(struct key *key)
 	if (!payload)
 		return ERR_PTR(-EKEYREVOKED);
 
+	if (payload->payload_datalen < sizeof(struct ecryptfs_auth_tok))
+		return ERR_PTR(-EINVAL);
+
 	return (struct ecryptfs_auth_tok *)payload->payload_data;
 }
 
-- 
2.51.0

