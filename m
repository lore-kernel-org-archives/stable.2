Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523166;
	b=SBTrCavOqLMpcSVV6xQaHKpkdkmPvB/xVXag6IgqTBKmO2S+qaVUTPlig3cubpFSyWsi
	 ev8gpGherpe6U1EnQyRvdujoxrgjG6Hq0BXIoh6nbgrICMzmHJiXxtRBIYjrZjplUkEw2
	 z+IkX1DpkXp+lcmTCQDIAm2wwXKzdMZNXaUhQtB+y0cKEptTGR1pDJsAjYu4AsPGYlRL7
	 waT9tJ3LoGDkCI2I6Y7E/4erGah6XhJdvPRyWCcTsWCQv7copXyE4kguJlGy7I9xT9yPw
	 cgHZ1/Y8ofpnMiMKciql/q9Yek5zQHUL0HOQnjzptygcqOqxd2KAGkULYEUFthgvvbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T9Uv2op32zHohJupS53Sf7SqghzNQXe+QDtOgKlIHmA=;
	b=lPlV++h71ID6iWZi7ccmU8cDbcpjvJDjiVQrZitnlXXPpmysu8QWjnxElkTYwpVZgdd3
	 l6a2scstKVnhIBbPfTot3Rc2EpzcB+e++dXlbXfSugnRjNizd/0hUvcg1up+cWuWhYeti
	 jKcG98+O8jjXUwchNSxFbYEYKx/PGq5oPNyKpr1LQI9lRfntIIAenEOhsI+iMKMVeXCpp
	 kY/wptlxVAW33nf7k7K8ydJa3j6F++YQPzlL7OyUtiprFfHgQurWpdT/93aWxSpS4NUp7
	 DvMavXQHf+klATmIfkUDdcI/Yoc5gPkm90Jw4wPzLySV1ybcXmiaW7PPaQfMsp0o3EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvz.org;
	spf=pass smtp.mailfrom=openvz.org;
	dkim=pass header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=ZkCib3vL;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290F606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A290F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=ZkCib3vL
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso43653275e9.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 04:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1795523164; x=1796127964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T9Uv2op32zHohJupS53Sf7SqghzNQXe+QDtOgKlIHmA=;
        b=ZkCib3vLn5L1FYGdyVl8yaG6OI7H1M3kncwKfQc78DB+MB++hygyoxJebab7CsTe/Z
         S5xMOOQY3TskXBnkZMosBudb9MVr/SYlzQQ+zOLAbX1Sloxl4+pnw8JI6xFkV1BMGO0g
         gJoHPEjjs79dVtAYxnQ2n/N/+4F8P39wqEWNK83m5Z5fVud/QDU9U0pZSYTXyZIZYcoN
         33YOlhISn+k8OJBCWSt/KVBE7q6RJzxE3cChjiKxRaptLtTSskulVKwxoXmqAHdgnDqM
         FFQNuPuz3ycD6ZubfOV7JAgqBdi4T0kadTHfzK4DPfZPnY3/7GhsatjjHy3YjxLO7PPE
         8FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795523164; x=1796127964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T9Uv2op32zHohJupS53Sf7SqghzNQXe+QDtOgKlIHmA=;
        b=HLVR+eK791LoMr7GJb/bRSqo2jjYJVP63Yb7ZALrC1xRq9fI7Ott6nVJ1/cgJ1qLh/
         7ZgIlM8q4jTtWSr6rM3oR99ASZXud37Zefwz5eIizT3Jc5fcMj9jUlZbWgt5Ocr5vuNN
         yCVl4Du18m74/5ElVtYuTAUlCIx9E99+Bkg2bBkGObN89Bnzeatt0wkZkvcMEf/XeScL
         1Gxso716KvTk7bQ298Or/w1P6yuxO9c4DTXn1pXn3Szr71vbON4Am/+58W5qfE3Lwvzx
         7CPF8SChOD+8ftarDnTEb1sf41a3N6Dr4LzlWmxPLkw3aQM+JiTngbWkc+HOEpykGd1i
         W0IQ==
X-Forwarded-Encrypted: i=1; AL+hErGH+XksZphyZyDAVuum+q41awcZE24h0bpd4JYHad+R59CRiFSW9cCZTBHqZ67JiPF+4jH9laY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TVBvqR1oUZEQk3whwxpE5hdMp5Agpsatf789uMdGpbz2NqXsr
	i9ya+/0jZXubXw/5Mk2csBfKcg8vkmS+zTUL1T11YgS+85uBpqSMOOxTT+IqQVYKfSo=
X-Gm-Gg: AZFdTZcE2nSerSsm65cwvTZHeTNrqNfz8pD1nGCGuiRP4Tskp6GNOlRV0pyTtBueYBo
	LanSjpdB+rxWK4c+LAPFq8Bbcwx78VVbQFMLZHFUQPjX3o3Bni890VRka+TMk1mFvk6Xpo2uBRx
	la406o8gR+T8p+Qjf8CVg7EkQCV+js7J4bMCkYhSC6EcRPUXq3PBc0CjROSnsSjT5t/JuXlJ0Qr
	Ul+4ZylEwxm4zimCYJNoWYhL8/41TtkuV6FL3+tKx1IaiIPOxeMvRkwhdvGClsx4cy+n0YzoQ8W
	VBKnfA97ql+P+AVsx0DN5RapzznCgd2joGUoPZpYSF2sXn6WCvfzugC9s1gC7Bmy7z763Av7S3h
	YD+ri7DdXHYfhUi9Pn5BxMUF1KefaIr9+2j/NZmNrtm5cBI3bUd9am2mE0Dg9fM+ntIVgH7Yu7p
	b077sicOcJ+a7sRLOhat20Pm0JsOOFSU/5BINFDp8sw7FyLDibqUlCincce/lYjR6dDW9UtiISH
	t1MsDch9cXBlbTd/nEs4PDXbu/y4jCDNcccu0KDz66dS60/KJMk/dNNrKngjTJpqIy1//jpqU39
	HkbdfxiYTx95SA7z4zIeioWF+Ac=
X-Received: by 2002:a05:600c:46d0:b0:4bb:8711:fee8 with SMTP id 5b1f17b1804b1-4bb8881894amr289262115e9.20.1795523163953;
        Tue, 24 Nov 2026 04:26:03 -0800 (PST)
Received: from artemis.sw.ru ([2a06:5b06:b600:300:8dcd:31dc:bf64:9564])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm423615975e9.15.2026.11.24.04.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:26:03 -0800 (PST)
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
Subject: [PATCH v2 0/3] dm era: a metadata device that never comes back
Date: Tue, 24 Nov 2026 13:25:58 +0100
Message-ID: <20261124122601.436965-1-den@openvz.org>
X-Mailer: git-send-email 2.55.0
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

We move running containers between machines without restarting them,
and their block volumes travel with them, so dm-era tells us which
blocks changed between copy passes.

About one move in three ended with the volume dead rather than moved:
the metadata broke, every commit after it failed, the target reported
"era Error", and the writes it tracked began to fail, which takes the
workload's filesystem read-only. Rebuilding the device recovers the
tracking, not the filesystem.

Three unrelated causes, all of which the kernel log blames on the
space map, which is the victim. Two need no bad luck: multipathd asks
every target that appears for its status, so one is asked exactly
while it resumes, and again while it suspends. The third is older and
wider - a transient read failure in the persistent-data library leaves
the space map short, and the next commit makes that permanent. dm-thin
and dm-cache reach it too, where it costs a transaction rather than the
device, because they can abort and dm-era cannot.

Each patch is reproduced on a kernel whose only modification is the fix
under test. Patch 3 must not be backported before patch 2, nor before
cca2c6aebe86, where the resize goes through the worker the two would
refuse.

v1: https://lore.kernel.org/dm-devel/20261118110239.2910290-1-den@openvz.org/

Changes since v1:

 - patch 1 no longer moves the decrement past the copy. Holding the
   copy's write lock across dm_sm_dec_block() raises the number of
   blocks one task holds, because the decrement starts by shadowing a
   bitmap block of its own, and the targets size their dm-bufio reserve
   for the peak without that. The reference is put back on the paths
   that fail instead, which leaves the order, and the peak, as they
   were. Reported by the Sashiko AI review.
 - patch 1 no longer releases the block allocated for the copy. That
   block is leaked on the error paths, as it was before the patch, but
   releasing it is wrong while the space map is in bootstrap mode,
   where blocks are handed out without a count to decrement.

Denis V. Lunev (3):
  dm persistent data: put back the reference a failed shadow dropped
  dm era: refuse metadata rpcs once the target is suspended
  dm era: construct the target suspended

 drivers/md/dm-era-target.c                          | 10 +++++++++-
 drivers/md/persistent-data/dm-transaction-manager.c |  9 +++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.55.0

