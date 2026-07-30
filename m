Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4443AF64B
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392795; cv=none; b=KARHe2lXhZVdclO3N1lNjQWmgaLbz6vuDNYw6ZNYcPC6MmcXainuJYFB5mFktm4R1kzd7T0rEZOCGBenvIz5PreHuHXjYIapWSdrkL9wpxV635emj33kxqtMs5eXWN60l3D7iwReJJ0Dw5uNIe3G3hL0LcGhgVU0aASVPs33+W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392795; c=relaxed/simple;
	bh=2Wi3i4Vjg7+AxOlXMBs+6tkx40vpBZwTeE7t+8e81gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIpOiaXgG42jV/7qIXzeNToiLnI2YqI2JHFum2b+yP3Z3ac0b7PG7RLqD0b7yldKdask3r9vAEqMl7l7GpLxyzpVy2CnmsUR+Uuz8A3h6w91zyN/XkHm0kXnJ5Q4o/Pcw8NxYoaTKNfs6NU+uodeMjGwWN8KDtM+f1EfGrTSjyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPg8G+tb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPg8G+tb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceae1ed204so22607165ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 23:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785392794; x=1785997594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3EaYXPThWNdkG4MwcQhWQJEAKHoDeZpU3BU1Rq69yw8=;
        b=MPg8G+tbPi15F6Sygfg6gANAY8vG53lXSA6/7t5yEiugySSlBHs01dhNQHdaAJ/Uf9
         k2YAfKZHVaBwMyPaRpBgpYeetoyD0qlugbnhZApyhOEun8yhBMHinhxlzYxVzIDiKd/M
         qGybnPUduhWfX+sN3FrZ8tdVENEC4rAViwuMSpzT1zE6emCKhCmgoKQWtLjg0TiLOWHo
         b7f8cFY70gQWYY/EGdUK4Lj9WjdaElHf6byMUufYi9xBkohRBJHDdhOhg/8Xj+jT0/zc
         ODlxlemyjKiOfn7wo1tADlOr9AHpBSO9H33b7NKuRSGZ+vh3ymr0KwzjpBwJ9fCPKHKv
         SKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785392794; x=1785997594;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3EaYXPThWNdkG4MwcQhWQJEAKHoDeZpU3BU1Rq69yw8=;
        b=dDXmSfcHpq7ATCiyncMPHee9KSX8BXYkcj3jPI+XzvR4yHHrCBJ5CMXoiKa/Zbw30l
         m8q72zUt/tSeyVsgjPtFqiKPH7telnE3M75qCyhnBN0D5BotIn0z6z+aWQWbTw472Udr
         cidG65gGxDSdbZLPya9Zp+ZjHB84ELyFe59U4Stm+Y4uKPmPiViDFuErxdG/1CzNY4+j
         oIEk9K6cOZJBUvzhspoxW5YVGq4Za8yfoFW7Az5YlRjhWhO9B6jA/RBUy/AxcM6FBppE
         V+gsF/qIwZ0tQH3/pt6u9ekUArbk8Egd55jMjVIG3qzfenxRZbVDD12+Qfben+ptKZU0
         BL5Q==
X-Gm-Message-State: AOJu0YwtDLrp+YVstQY6AOot/WNGFXQ0xs6EN1XHMlwA6hSQcZtOLglf
	iDxxQVGiP8d2VRtWtc3fFcLFy7oAIAz+75rFwSmFbS8EZEtcUnDyyR+h
X-Gm-Gg: AR+sD10h7ejP2vokNC9Dewn8aHNBJH7iclPucHyMFimYQyPefEbnozTxlnD057oz6BC
	g4V4Wi4XNnF47vPx6Q8OtdrptRXJLw/NwAOktOPcckPs42uoAJdR9ItwaAjhTYOnclc5tq94WFZ
	hXftUsCyJpw7jHDvt2HpmHRS/PfHxQ3B0JdnApEjc2qQajq4DuuUhYggVwoiPLhEL7oNYdApKLp
	M+YDnX2xwIS3q6125VL2aJ+ZO8pA3XpXjEiZwRJp65tRgVLC7lFchdWKZDfAKZ/E9ll3aiDRy5M
	8F5sPcNMPy8cvcOIzdNg7cNjLVjhjWYir7IJFQdVk9RsZzywJqvltVOOEPGFnf/fhdt+cCuk/Fv
	+i5HtZO3oVVWiziMd+Yu6pQoPRlOisfdEc6EJLMCkzG8U1x7EjpXRcXCC+IbMc//4fHDUVcA/F0
	CNXaMmNOt5kgMZcW5P0VKyqv8O86uaH8F8Esy/ovTPSFOWDGdYP0o+bqf80JNF380c
X-Received: by 2002:a17:903:1aa7:b0:2ca:281:27fd with SMTP id d9443c01a7336-2d035ca538bmr15480515ad.25.1785392793712;
        Wed, 29 Jul 2026 23:26:33 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc9bd4sm21059695ad.48.2026.07.29.23.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:26:33 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	Sandeep Patil <sspatil@android.com>,
	"Andrew F . Davis" <afd@ti.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v5 2/4] misc: fastrpc: don't publish fd before copy_to_user() succeeds
Date: Thu, 30 Jul 2026 14:25:46 +0800
Message-Id: <20260730062548.231239-3-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730062548.231239-1-shoubaineng@gmail.com>
References: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
 <20260730062548.231239-1-shoubaineng@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fastrpc_ioctl_alloc_dmabuf() calls dma_buf_fd() which installs the fd
into the caller's fd table before copy_to_user() copies the fd number
back to userspace.  If copy_to_user() fails, the fd is already visible
to other threads in the same process but the ioctl returns -EFAULT.
The existing comment in the code even acknowledges the problem:

  "The usercopy failed, but we can't do much about it, as dma_buf_fd()
   already called fd_install()..."

Now that dma_buf_fd_install() is available (introduced to fix the same
issue in dma-heap), apply the same pattern here: reserve the fd with
get_unused_fd_flags(), attempt copy_to_user(), and only on success call
dma_buf_fd_install() to publish it atomically with the tracepoint.  On
copy_to_user() failure, put_unused_fd() and dma_buf_put() cleanly
unwind without any user-visible side effects.

Fixes: 6cffd79504ce ("misc: fastrpc: Add support for dmabuf exporter")
Cc: stable@vger.kernel.org
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/misc/fastrpc.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f3a49384586d..c5143cd25767 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1709,24 +1709,20 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 		return err;
 	}
 
-	bp.fd = dma_buf_fd(buf->dmabuf, O_ACCMODE);
+	bp.fd = get_unused_fd_flags(O_ACCMODE);
 	if (bp.fd < 0) {
 		dma_buf_put(buf->dmabuf);
-		return -EINVAL;
+		return bp.fd;
 	}
 
 	if (copy_to_user(argp, &bp, sizeof(bp))) {
-		/*
-		 * The usercopy failed, but we can't do much about it, as
-		 * dma_buf_fd() already called fd_install() and made the
-		 * file descriptor accessible for the current process. It
-		 * might already be closed and dmabuf no longer valid when
-		 * we reach this point. Therefore "leak" the fd and rely on
-		 * the process exit path to do any required cleanup.
-		 */
+		put_unused_fd(bp.fd);
+		dma_buf_put(buf->dmabuf);
 		return -EFAULT;
 	}
 
+	dma_buf_fd_install(buf->dmabuf, bp.fd);
+
 	return 0;
 }
 
-- 
2.34.1

