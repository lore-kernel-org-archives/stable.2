Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620FB5519A3
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881220; cv=none; b=Hf0p+pdQAJReUHjkvS/qHoSHG+3HKUn7jjev+/2k7DF3wNa6pLaO1GWw1n6wUVIcXbyUJqsdkNlHHmhJgNPdpv54TUnCkPuAYhFSzydtsp4kgl8/PJ8mZUB+LpjoB+kuwom1xezcatR/e98my9Twrswuv51n+PgaTLwRV8UHkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881220; c=relaxed/simple;
	bh=RVochWi1fW+MMf+h/8ym7cr0FagOTLPCgc18rog4v4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2H1+yIpAfj/4jCzHH/0+efO8bO6PfcwqONXzhM/kNQKT4DrBXuP+u+elLcpOdd9Lv8+BLFG8mBe5eM4xsS0bzyq4xRga0pI2VcLNGnoxF2yQcQqCWmV/mVN9P5mYZdDms7bnWI0ry7uAaQqOqylTaP4CtrI0YXXrIrnV2/I8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPnU7NhG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPnU7NhG"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c95395230so42479021fa.2
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788881212; x=1789486012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xZ10AumeYeSSsmJsJFaCl8FgVIUzu68KYFIXrl2PZu0=;
        b=PPnU7NhGZwp0DYsxlQMqgxNQy32V0gwvBdRBc6a8Nx3cLQTiXGaMnpY2dNjmiKB7IV
         N4w7bb2ADNmU0RWlXFFRysYqyW/ZjZDk4RDX0Z+1jFlq0YX4u3tbDh6OTde7UqVERJRD
         9RTe++ZkVXmiieaUJ0pFtmYymeknbWIg+EBzLr/FOKKDr3zF0toCj8Xe5pNubi+A8Ixg
         TQPzo+btaevnDc2t/wPG78tPp0HayF7oEE4dHuVhmlEaFQIqrF/2hxP2Vfheje206nLt
         XFsRF2VgWZSMR2o7UxheUT7saHo8/o8pYR8M5UTpkU2sBJAc2DEH7XXFDf4jK0Wy5sJX
         jTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881212; x=1789486012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xZ10AumeYeSSsmJsJFaCl8FgVIUzu68KYFIXrl2PZu0=;
        b=Em4kJRy+SYKSgoXv2kPWcI2va5qGQV/9nYxzu8XarySsKh0Tfuro86qhpWOM1PHzAq
         lJfL3G7aanDGuzRl7+5e4Pg7q1W48qFOkapVE8sfzXfn9QDiLz+0hPS012l7djRKENlx
         RY2ANNb0wGNqTviB2FSCgJ613bZ/2V4JX5mQZTPcdL01R68b+OTUGeCZqnnwKcIlWE+b
         JXicb1RPfz62SoS/NoscU4W9GxdsSFePlDENFMLhq98DwnbQbh3udMqASStjiWT/KOTp
         V3SLPUNv5MrIgq4sDa0AaMYq8qnzfHNjJ+vqrxHvKu5sXHZOzaQYKVYs5bI5NNMz4+UQ
         5n2Q==
X-Gm-Message-State: AFuF++mj78LJcZBf6Aa9a5ylWQOYItM2M+V2/NgjW3+fD6OFm6L1x7Ev
	EYT+fpuwFOLBT5n5/orSPHw6d6Y5Z0UYINAJKZoWKpDZBOEudK218Lo5ypky78gR
X-Gm-Gg: AYBFou2gkqPZDKqD++4UFPyOrKPppUemv0VWYzhGaWIUaQ0TFKiD46heaBaKnQOyliG
	LtvmtfElRT0bZXeH6nnEanUMPVPIfBAsDrevFo98XYZa0/bPk4g2UyZEmENktY6Qcr+rczmPwRT
	i8d7B/3tyK+ZzzxMNFlauLOQ8OaQBelHAXmssD/e1Fh90UzD8jGkEG8OKREw03kj97+QPtpBuML
	Tc7/d7cgdfvLHw5KYoj1XgklxIhwat6kdA66kK4KUQ+Z/8dgOKyH1cUUDVxxnbrol9Ix/nWGxCU
	KrSZWIPaVAQE30rQYtl6DVzRU61fPkmvF63OVanM5xfmLG+kiM/q1hy6mCfJxsIPZJks4nCKLth
	MQE4ivIMrBvsDNu2rvcsuK/R/a9LNi/OFqAn/MtjB2Wswdi/0pPcN/1pmAoHMppyqcosgPCRNlO
	Amf/Uql0uYU1IozVnNYZVoljbDjXc+RVdW3wAw9aRzIwEnwOZgRiphaxEdivTEtlTiZ7U=
X-Received: by 2002:a05:6512:2c04:b0:5b6:1a81:1c8d with SMTP id 2adb3069b0e04-5b61a811f6cmr5021576e87.66.1788881211560;
        Tue, 08 Sep 2026 08:26:51 -0700 (PDT)
Received: from grower.uveon.ru ([185.32.132.237])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166ed098sm3116119e87.22.2026.09.08.08.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:26:51 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Deepakkumar Karn <dkarn@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.12/6.18] afs: Fix leak of ungot volume
Date: Tue,  8 Sep 2026 18:26:27 +0300
Message-ID: <20260908152628.200856-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

commit d672c276f685a540ed2b2a8bafaed4650a89022c upstream.

Fix afs_lookup_volume_rcu() so that it doesn't leak a dying volume if
afs_try_get_volume() fails.

Fixes: 32222f09782f ("afs: Apply server breaks to mmap'd files in the call processor")
Closes: https://sashiko.dev/#/patchset/20260609081738.770127-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260622090856.2746629-17-dhowells@redhat.com
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Deepakkumar Karn <dkarn@redhat.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-80878
 fs/afs/callback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 0a09a9ca3c6b..652c4301d56e 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -138,6 +138,7 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 
 		if (volume && afs_try_get_volume(volume, afs_volume_trace_get_callback))
 			break;
+		volume = NULL;
 		if (!need_seqretry(&cell->volume_lock, seq))
 			break;
 	}
-- 
2.43.0

