Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296694;
	b=GA8mKIrGfriYRLVv65iP7Sq3nBrSkYHeSvlofiou9SLTJa2ElEt7j1oqrnW5KY1XLl5A
	 oP+AeOgfe4CspgzNiofZcFdEbbxATeqbA32TumXXkpOPU+lgQL/6u6LN4N+pVtWZ8E28C
	 1504NkBJMWha7KiGMhrheyamzSsKPQ0t7YCrg223fvksvA5Vk39Jl3mTQnr1LtvNRGysA
	 MFzRZFZ8zPW9deF9XJ82BFKCGR8gJmJX98iXpy8P7Zxn3wolwaqeddIu+e6yTrWxxJv1U
	 2/AIpc3+9ofUqRXSxaO38+hLiibCClhfCbPu5NxCtmoyAEyv1Oyu87GBoQaBLKjefhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6vzBrhlTnlwPAG0hofbykkERjUBx7pLcogh27EOB4Io=;
	b=K03NhkFh7yUbwf6HtGLXphF6woVDP7FzvEkGYORfO8fOz7NzIvFVq27UcIPa7zYu7TrO
	 nvlI/uiS03DoA2LmKyrqBnHOqwXXbGojbHqAIo8Fs9rHSLT+uLxyDxWY9VagcH2IAkeLO
	 DBSIA1TKV2+/8cbMcSdXAam4c8iQWVLt/2lVtY8IFeYVy14bLFeDHsOM21Nx9GBQYHGAt
	 vWPbanNGh3UhbCx0o1a+E2fT3YtlRiD81Eydx4U1y46a2LKOqg/uIAsfKUIrAhVI9kAO1
	 q/rQEMqa5w03yjfjAJKCgWZScJ9RLrspFLRJ21dBkpa+0Zu7DDh5ygsycxyswHfL88g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=mTtkSiaz;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39F606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E39F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=mTtkSiaz
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-85ac281604dso957334a34.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296693; x=1795901493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6vzBrhlTnlwPAG0hofbykkERjUBx7pLcogh27EOB4Io=;
        b=mTtkSiazsRr78a1ZfVfbgEDxIuhpBixrG6veWsaw9Sjy2easSRb909TgZle7kvjwoG
         bN+Q7QnpWxH5ovGmxouAfKYbz22iWXGSSRIj9/3QaRvIgWrTKOUSuslXGExVnk4TU7Ia
         KBuDW0iDOUW1KM5OqMsGVBqSpDPXmZ7+obe4PdTFyUyOIt4r9Z7VdBKHgJLMZBO3qO1G
         K3hRTHgq5C2wOVUyjuMWDI8jhSMaID+uglu/3p9DOIwUjXY+44y8Th9yBA/Eh68Mpruz
         /L612xJLvseTzSB2M52W84srY4HxEV1GyvHG6nseDqrphoF7hW4JzUUjNPwX1hAT3eZQ
         jLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296693; x=1795901493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6vzBrhlTnlwPAG0hofbykkERjUBx7pLcogh27EOB4Io=;
        b=ze48bkdpL0lNVav+jXCWwR8qLmJ2amIcIcy1ta19ZKYHKEk4kHoOrgg4yDL/aPn97w
         Yk+PrGHTJUm5PwnU2vquI1L5cVYyZRRpY5J9IAxusGqS2xLcheyuo8qSO5R60cBN70Fi
         v7JIULIEGu43KFPJGtMdabXA8yo7t1dDP9lTQmH9UzCz2sjhhq1WT8tsehjceXYFYjuy
         j0ahvfQzEI76fyI2SNqiQDRmhQUVL7rdjO/6/Hq++jdOUtrI4RuglSDzRpsKhdFzSEde
         g0A/eeHrFKRbJAIVbDJGETAZ3BBjs0+oeHPB4zPWeAv0B9gceQyT92kEkpZJ7VPZEJDa
         WXPg==
X-Gm-Message-State: APuU4Z9cFyWqtlrmxPg15NdSB+1/gTAzG8PJHHRjpsO62OZwVAiSClvD
	P2c5rpQMNa7pX/WXjl7VoPPeLp77j+h9uqFiS0Bj1f38a/yQpcWJlEYMm219ga/2S5Liv0BS5b3
	s2qN8Hhs=
X-Gm-Gg: AZFdTZcpsclEDS06Di1SRxSEzNgRgVCaldl/Yv+5cEyxmCbp0TYBevO7UrhxYilNMud
	1rDEdBmEmYo6AgZzfd84HsNxShNO9caspohTz9SJ/F9RmAbLUHUoophSND01mcHu6cJMQLZ+mIA
	+Q4b1jVhbqPz4PxXnae603731c+SaslBHhucou/KcWn4POsCBEnDqTDUQOcg5/kf4SuVjKloDBq
	iwE779F+Zm1JOgJwzO3ULzJd4m7BzvoLGNluFziMNtt61w2u+8cr5vrVDczb3/LvayVS1GY6vYZ
	VFMDckzZsA8hYi++uefLGFJh1U6O/Bb7HPWzan/x20VZ761EGAFN2myGxAW76Zpozpb+luAaaaZ
	5VuiXuNJpsSUKZxjaZSgrjJsvn7DP5LGYKQddQiZnWm/A37i7McBTQu+6t43SBZO41ayMPCBwH7
	rXnkIkmIFMiQaaQbcF3PjG8lTYTVxcT/FLBP2tg28jpY02/CwyOindFu96s+YHbimIE/4ZJdqeY
	Yti0mT4iPAYrpvoJjDsL7JzjjNWHYNEzuexNlIUHQHwFVMs+S6OL71aglWrT7Z+EQvkpnFuetuM
	SZMwvSwr9IhKPc3Ld4xgnVMVSGXOM5iaj+yIk+OTxMDXSv88C7L6XoSwM0Lfn7O96CYTjK8GkMT
	JsbNUc/68/zrpvtUaxScYuueNW/cueGQ2c0UU
X-Received: by 2002:a05:6830:2b06:b0:862:ca2e:918a with SMTP id 46e09a7af769-863159af93cmr8372785a34.19.1795296693492;
        Sat, 21 Nov 2026 13:31:33 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d33sm4946113a34.18.2026.11.21.13.31.32
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 8/9] io_uring/kbuf: initialize arg->out_len from arg->max_len in io_buffers_select()
Date: Sat, 21 Nov 2026 21:31:20 +0000
Message-ID: <20261121213121.1789042-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213121.1789042-1-axboe@kernel.dk>
References: <20261121213121.1789042-1-axboe@kernel.dk>
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

From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

Commit b7322810d1870ccc0d293ad383d94ef583d5057b upstream.

io_buffers_select() passes &arg->out_len to io_provided_buffers_select()
on the legacy provided-buffer path. Because callers initialize
arg->max_len (from sqe->len) while leaving arg->out_len as 0,
io_provided_buffers_select() sees *len == 0 and always selects the full
buffer size buf->len, ignoring the user-specified sqe->len limit.

Initialize arg->out_len = arg->max_len before calling
io_provided_buffers_select().

Fixes: 35c8711c8fc4 ("io_uring/kbuf: add helpers for getting/peeking multiple buffers")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Link: https://patch.msgid.link/20261116193146.65315-1-sidchintamaneni@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/kbuf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index da6b46244e6d..9d6b7c433eea 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -343,6 +343,7 @@ int io_buffers_select(struct io_kiocb *req, struct buf_sel_arg *arg,
 				req->flags |= REQ_F_BUF_MORE;
 		}
 	} else {
+		arg->out_len = arg->max_len;
 		ret = io_provided_buffers_select(req, &arg->out_len, sel->buf_list, arg->iovs);
 	}
 out_unlock:
-- 
2.55.0

