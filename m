Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73D3F789C
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481685; cv=none; b=I9ZQFbzdWNLMgxJhNc633Pbh34Gi7TiSDJ5vZX3FUJ6l/+LZvhFFfVKGWxaGbVNlIrjSMDikRK4tXP9JqN8hyX9jLx6YnAUmB7LlcJBNZ0cPVrwXKY7BbkGLY3Cu+/dL9CkPOt7Jc1h/KpYocfRJXOBrZmGy2Q1hx2m6h+VAGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481685; c=relaxed/simple;
	bh=EmKi2C493iDbBWdx+ptjz1WR/dnYiIh7do+rNIXRds4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MSCuRA0HnzC2np6351j1UCLRotm+RsQ93TwUJRd7KvJeC+JiDmR0/ITEXntSJz5rOJ0nxUUIbw1Kv613LEjJqhyRjxNMJ1+qUOTohh33ZMauF4mBEQbJO85qsZyJS/yNfCl/0vQt5cTPuVvtNgMf56LETZBKki9mqPXZVExkhsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEM9Wi+x; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEM9Wi+x"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-46e4764ca48so900674f8f.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481682; x=1783086482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93eF1nP8FA0jQ23r3uigA9hOS1jY1X3Q7tz40Q/msFw=;
        b=rEM9Wi+xDZuhVNg3+Bk8z3Lo8gyU990zwqmMju+UiKO9c1Hw1SjX2GTHMViHPIXD9w
         Y5WZrr13OnahqQP6bhvivNwKS+yEbv05ieeOKZLIxQWOq7V64VB6cuWD+z3MwisMe6Af
         L2Jzxa00lLzhkl622nLdg378PlJzSWMAIVh72UrRh1dq8E9S1IdnZw8en/Vimtc6igc3
         QTzQAi9I80RFWkLY0MMphr+8XNBuTp0zLWFntbuKrKG3vywTw+MW+Dl5buGOYyxKOwl4
         rAl72Dccg3eyWMGj2swLqAugesWlaljxcNWQriWMflHJzKWYrVcMj6OkaqMVQfYESRpG
         wrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481682; x=1783086482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=93eF1nP8FA0jQ23r3uigA9hOS1jY1X3Q7tz40Q/msFw=;
        b=FcbIhdyXmtI0TQWE7IV3yweZ0fiS1GiSvFE38YWe+J4UTm6FzeUWhuBbmh5YLdlN3n
         dusKwGSMrmB0nlUdJg4FE6x7lkrHgwHox6lQjdf5fBRMTOeUBBZ01u9J/Cy+ekelW5Wd
         5ATSwX+2TQOktgziv+lLYlsW+/+YKY9hsZCay9dNVKw5sCWtRmApWpe8XfCw50vZAnZJ
         fIcTt/6h+/VqBds4FFZfCsSnMQdUUkAN6HzAaJPhp9yP52h/zKFlRaFmty8x8rykiLy0
         zZMUtBepycNdB0HBbyQER5ia7QdwTSAcgU9A5xg542vU+kJQdxseDzivdqq34jEdymzR
         PteA==
X-Forwarded-Encrypted: i=1; AHgh+Rrl7NLemfDVEiiJxvodjzWa0avpLEHDzikMbdbb1ymA8wf7IIvtVpa/wVpbyUZ3yENYLJTxiJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/e6WT+3jxJVaPqCtq5I8h/hQAeyUyYwnstf45hpZbQG/aQpi
	oeX/ib17DykXL1ALI+QXjpxAdZ+P/tLEdKbqRGHyJxlYPbrr01SM0cav
X-Gm-Gg: AfdE7cnK4NoaFGaLzblzgNpse0YsdtanCd9oVRlTkgVDun/yhPcry63y0r1NPhy1kUi
	FxUib8zJj3Y7enwDqF/VR6K1g/GkGYS6kP6ceq9rQRPVt/7p4kELfTPkA1j31YKesd+B0PMJAKF
	yysLowq78OKwThjFiLJZ/ZwpPaSOw7LBjiYaDvud+9sf3BirPdyRdxURnNjqO6J/Xrthkm51N27
	7rqAJG9v3RO9IkNfepltPzpQ7O6bp+dq7DS8Nh8hziCO5cP80DyLlWE7ZGW4dIbyDfPCojIjwux
	OP6IgmoY0jOjHR1zFol1Jv+Teej769jCcfJ7bbIQPR/2ieeu0aSdnkmvVjOKi8EftDKJmUko+9G
	K9ypD+y/JDDJQubmRlzO+mnR0qHaUqFFVOPwqUiPal6VPlCtWOBkirCvjfLKZBkgGnEmoymWmGN
	CdiqoMHQ2iQqadrjIJaMPNkkNP/vlwMk4fgv0gvKZGLBpQxqr7OAWuIQ==
X-Received: by 2002:a05:6000:2f82:b0:439:c18f:5aaf with SMTP id ffacd0b85a97d-46dc2359072mr12358019f8f.34.1782481682461;
        Fri, 26 Jun 2026 06:48:02 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-60-93.inter.net.il. [80.230.60.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46efd7ee1c7sm7987878f8f.14.2026.06.26.06.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:01 -0700 (PDT)
From: Omer Cohen <nevergfx1@gmail.com>
To: tiwai@suse.de,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	security@kernel.org,
	Omer Cohen <nevergfx1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/6] ALSA: compress: fix buffer leak on set_params driver failure
Date: Fri, 26 Jun 2026 16:47:05 +0300
Message-Id: <20260626134709.27883-3-nevergfx1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626134709.27883-1-nevergfx1@gmail.com>
References: <20260626134709.27883-1-nevergfx1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_compr_set_params() calls snd_compr_allocate_buffer() which stores
the new buffer pointer in runtime->buffer, then calls
ops->set_params().  If the driver callback fails, the function returns
the error but runtime->buffer already points to the new allocation.
On a subsequent set_params retry, snd_compr_allocate_buffer() overwrites
runtime->buffer with a fresh allocation without freeing the previous
one, leaking kernel memory.

An unprivileged user with access to a compress offload device can
trigger this repeatedly to exhaust kernel memory.

Fix by saving the old buffer state before allocation and restoring it
if the driver callback fails.

Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
Cc: stable@vger.kernel.org
Reported-by: Omer Cohen <nevergfx1@gmail.com>
Signed-off-by: Omer Cohen <nevergfx1@gmail.com>
---
 sound/core/compress_offload.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index fd63d219bf86..XXXXXXXXXXXX 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -665,14 +665,28 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 		if (retval)
 			return retval;

+		void *old_buffer = stream->runtime->buffer;
+		size_t old_size = stream->runtime->buffer_size;
+		unsigned int old_frag_size = stream->runtime->fragment_size;
+		unsigned int old_fragments = stream->runtime->fragments;
+
 		retval = snd_compr_allocate_buffer(stream, params);
 		if (retval)
 			return -ENOMEM;

 		retval = stream->ops->set_params(stream, params);
-		if (retval)
+		if (retval) {
+			/* Restore old buffer to avoid leak on retry.
+			 * Free the newly allocated one if it differs.
+			 */
+			if (stream->runtime->buffer != old_buffer &&
+			    !stream->runtime->dma_buffer_p)
+				kfree(stream->runtime->buffer);
+			stream->runtime->buffer = old_buffer;
+			stream->runtime->buffer_size = old_size;
+			stream->runtime->fragment_size = old_frag_size;
+			stream->runtime->fragments = old_fragments;
 			return retval;
+		}

 		if (stream->next_track)
 			return retval;
--
2.43.0
