Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714070;
	b=wZG60fFctAo2JPxx0zyCKc6tLeguOB80/ZMj2kYaAECzSuEpUqA9SOxnFEjKyyCa5Ydp
	 w/87r0RIHPFaJ6bTKjtGHlyOB2hV6C284yoDh8Grq6nLu+zB4CgLePF14BOISeWpalw7u
	 8r4h2To8GDT1Rm/AjQnUeGhhkwAPsX+LHaMHrCGDpHG3FtQ1IYYWQ7RsLaHrchf8QxQNu
	 kQIwgbxOurjzSc+qriRoprDyTWlaSZQrvQft8QN3rJG6Jyl5fts4b5VnOo+sryLNDgSsT
	 9D7/mt4WCzHk4pPC6Te9CUuJfG7mYsLgzaCsW9W7VdZ7Cki15OxjWoepHoi1dPzfrpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714070;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8QIiw2d/LYEr9rAD/W4IkJ9wJhl6QaU8H83tWbgksj0=;
	b=VOhhYmQwqeJ+M92o5XEyjDxDDKHVxgqWoYIuLnG8+wqhzugF+pbnPJXlsDrEbN4TF502
	 9vpZQQpyyuBm2PEi1qcy8AD4UrO7lYRD1sVAIyN5TcKVKVhbnCDg5ZRbegMWTIW4YdeGu
	 Bx7prF4sZy2dXlMsVgaAhnpo+1gKdYKtzHGg7gg5px0AW/kR2bJ0nCvuP0lfXhChAuCqG
	 Sr35cu4kLaYjc6HO/lyX6alwDaOZ5j0Bj2Dy0RCh/Kj8kqgDKtBCJWiU7WE/2xWLIPwFv
	 POemVAC2KsxyUvDjbnPZeXty7wG2hLaYa+zmpnEXi58F1xCJ8cOMVPTpHPRA8tnQxNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXQ64N8L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D14606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXQ64N8L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E521F000C0;
	Thu, 26 Nov 2026 17:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714070;
	bh=8QIiw2d/LYEr9rAD/W4IkJ9wJhl6QaU8H83tWbgksj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BXQ64N8LsR3QrmbypwBCqZ6d+r8MeUKXYIlXnuX61/dXTEe8K4qwxzDzOoxOKgi4C
	 7T97oaRyIqbU3Vb2HEUbLqOi7r5LlYLLKvV0selnp6+JpAwBfGolP7jPbDhBZUJ3im
	 pIjzQn9Z5AU4fX+XNTvGNsStjj1QAarmuHkucbYUV8eMUxbu7E6mFX5NH4SorHXhY0
	 xusU4ZOrSSUffKSjwQUzNuSOlz4KvZCmiRu5YL74zxZYNPpzvJsEFACEVxURMR7GwZ
	 YQGzv7rsYZJgfyDSSsL9aC1uDPFkSPtVvnQCQlY+N1IyfPApdYA6DpdXH2TrVoXYnf
	 99ws/GVG0NTSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Changyul Lee <lcy8047@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: trigger: free the trigger ID after device_del()
Date: Thu, 26 Nov 2026 12:27:48 -0500
Message-ID: <20261126172733.2775351-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112508-sinister-decency-b03e@gregkh>
References: <2026112508-sinister-decency-b03e@gregkh>
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

From: Changyul Lee <lcy8047@gmail.com>

[ Upstream commit d32bf759801e6df23038dc834622a122ec76a4dd ]

iio_trigger_unregister() returns the trigger ID to iio_trigger_ida
before device_del() removes the "trigger<N>" device. A trigger
registered in between can get the same ID, and its device_add() fails:

  sysfs: cannot create duplicate filename '/bus/iio/devices/trigger0'

For example, adding a sysfs trigger while an hrtimer trigger is being
removed through configfs, or the other way around, hits this because the
two paths do not share a lock.

Free the ID after device_del(), as the error path of
iio_trigger_register() already does, and drop the "Possible issue in
here" comment.

Fixes: 1637db44413e ("Staging: IIO: Trigger support added to core.")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Used ida_simple_remove() instead of ida_free() and kept mutex_lock()/mutex_unlock() context, since scoped_guard() and ida_free() aren't available in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-trigger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 59f863cb5efec..0c738f9005c06 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -109,9 +109,8 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
 	list_del(&trig_info->list);
 	mutex_unlock(&iio_trigger_list_lock);
 
-	ida_simple_remove(&iio_trigger_ida, trig_info->id);
-	/* Possible issue in here */
 	device_del(&trig_info->dev);
+	ida_simple_remove(&iio_trigger_ida, trig_info->id);
 }
 EXPORT_SYMBOL(iio_trigger_unregister);
 
-- 
2.53.0

