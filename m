Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8873B14C7
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029647; cv=none; b=Df5e5zgZjwl1lMsMW4EBPQU3+4+mx0k6vJC5BbPVzkM0Fmhi4QnMBvia+Gg/87pNUG5+siIQkGYvKwGGgcLZVrtzicyNYZwN6ddl43c6rFYYXLKNNQBAdCuTTKLwWsPPITEJl9QExYOUgCNcp9JXip2n26g45qMFHP5A72vHPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029647; c=relaxed/simple;
	bh=Uy7FphsDH/6m7cGZVypayztHXs5inLwbY1LCe/lb3fU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GmraLU3R9ZdLmolPbjhI/44e8bVCuXJzOlZaiTInF0/d9hN1e7C89PanO5brnuVtynKUUYYtOBApfT93+fAvOyPSfStbT5CHZISDLECF67AOwub2LHWiWfwdKOusHHHDKmVbnj0iraddE9bqOsnnze2GVAgKH8k2iNA83/UBZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZpA9tl5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZpA9tl5"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-383cb94f742so3802192a91.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029645; x=1784634445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9XJ+pkLF/zrrWNVQ3+TJme7MRR7lpIC8LYwT0f9F3iM=;
        b=bZpA9tl51WlU+QiBJo8jM1Z6kfYLdOPx2EyT+1a8r3OVqbH93QegbWnDa/UGcM9bY3
         +ry9inNECLk6OdJlJEstk4vJA6MXI7Jd9ZINBJTkLpSp5gO6VzvS3LvVzlkztPeItCAs
         WG2urDN7YBP3O+O9+0p7gKTTBdaMtl2LT2+eFlIbh/oCIIZ3BIpZGLmO42E0xV7UY/gg
         J5iU6zUpyfZFUleDZp5kSFv5sgrBv3hYWdb9a337HwzyjUbBCkpDHdG4Zzl/dB7yTPs6
         LczNcdEfMHygENFbb8nBwtQnRlh1ZO18wFyixHoduDuGUPh7w86NSfOPov6qVFroFXJJ
         pdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029645; x=1784634445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9XJ+pkLF/zrrWNVQ3+TJme7MRR7lpIC8LYwT0f9F3iM=;
        b=jrhQkJwPbkAEVA16dX3kk0+WvcIWhDXYXXLy+LGl9+xP9GyZdlvawwL4dJLsK1ezdh
         2wZ9m8eT5t87BJc2Dxdy8TffGyjRnkOP7N8o0Wx3hLCLieXa6ozdEy7mndWs1b9sIpkF
         8OBnKeAn1rU/LreI4fvY5klOH0oghApoP/0aNgn9F7uNsTmLE+wjPLq6aQ3P0mZNtiOh
         L4UxekJZEqHKvaj30ycU3ikBWvAOT3vl4Go8KfhYHCmnXoa3OJCoWPMcoBkEl10i3pKD
         yottwt3nAo9MU1JfwnDMeB/94XDUsEIksE3fYGa7SnAQ6exsCRtjJtseo4ei7Ua/CCiy
         EC9w==
X-Gm-Message-State: AOJu0YyJKW4RaZrR5I9Gk/CdkwsD6isZ2rQHkdKXc/EsEiVRF4ZUB2x9
	iFV+BiLmAEdwFt1Hku7jSyrAhpM5DGTPlb62cr4LzIri7uSmbH9V0XGT
X-Gm-Gg: AfdE7clouIwEhcit3YC/KRZa7boB6Ip0jrwXpOi6d3OP72hk60jx1SZye8Wfd647ouq
	smdYASkNT0XUMibLqdY7iaeK6R1z8U2VKtTcc0bc39mxOvkoaEhLgaR6254wxFN+8U5A1b7LVZY
	2dLopESgn0pKOx1Jyvz6gHCsFgGQrdA4y7clOqzkSoGPJrnLW13gtiXrWaDYFXECS9ucAHAaPXa
	Qw2dQSsj9r5h57uuZRKy1dOv50jKXj+RnsPGsu/zvA7jofP92u9d4sOD1QEx/3bLTvCB2dfF5Q/
	tcsnjiYjjEWocIOrFmQDPKDpyHwQpx33LbA3Sh9jqvkp0vZ/2K1n4I+1CxfcotDhvGdbGQSly7q
	2RWmIICX884rG5yZJ/QSgMvTbc3yuzaSZX48xf0bHBuuaVYuKY13M/7cMgstcIIn+KqrCcS3YiS
	auNQpbnXeeURlEtpwR
X-Received: by 2002:a17:90b:3dcb:b0:387:e0bb:5804 with SMTP id 98e67ed59e1d1-38dc7bc50femr12271219a91.43.1784029644922;
        Tue, 14 Jul 2026 04:47:24 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e17470008sm1356162a91.17.2026.07.14.04.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:47:24 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	Sandeep Patil <sspatil@android.com>,
	"Andrew F . Davis" <afd@ti.com>,
	Srinivas Kandagatla <srini@kernel.org>
Cc: stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v3 2/2] misc: fastrpc: don't publish fd before copy_to_user() succeeds
Date: Tue, 14 Jul 2026 19:46:54 +0800
Message-Id: <20260714114654.3885457-3-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714114654.3885457-1-shoubaineng@gmail.com>
References: <CABdmKX21NHc2=9Sk2F-BFpu6is0vTg-QXLE+wiFNEPdsWWjvog@mail.gmail.com>
 <20260714114654.3885457-1-shoubaineng@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

