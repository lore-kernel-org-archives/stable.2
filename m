Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106BC3783B4;
	Sun,  5 Jul 2026 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783259526; cv=none; b=T/VBlijdAuRJdcMXqyrLqlYUj3He8zxeWQ49Y1ha4DDwcVhJIyhVXSGe8Z8SZTBP3dpHy87A5s6z9PQI+qIAIH66dw1ZrHzb7ORoDoM+gw6Kq30xfKmf5vRuQVd0FRHt/JJxLaICh4AFg0IGS8raS49knIihEI9q8lgcZp68cuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783259526; c=relaxed/simple;
	bh=MWz+AiWcMBmm/IVpKupbMG1mTBA7Ba0IjeQ7nosE5I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Glfbe99WvcgPhRSOr48YEebRUqDWY/Z3zg0H9GUOW3lUufTtwqbI4WgQ1WKEz+yOjvTcQeDDPQuQFsKz/zNQj/k8ExQFzOhZEZ8//wiF8CDVZ3+A0sTXpOP0ir3Fw3d1WP6Sexh5jynzFUPbBlKx2/D+ovIv0AQQV3z9pCPVmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXdXF+HT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXdXF+HT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6B21F00A3D;
	Sun,  5 Jul 2026 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783259524;
	bh=hiXx0kh1llU+tqTb5cQLeELIhtzQB8YMaLGKmHcMmT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eXdXF+HTA76vk6XNS/vpiHTMSk+4FpMeNvRZmKgO8fO2droK6kJamzz2kJ8o2E9mW
	 UXXYCvFJ5fT1e2JQ+P9Tv3IJ76zYmA+czNJ9uy4Xg5XK1a0WoqHA3kDRrX+VbCFdU3
	 rqA9ifY2b9eHSUHyxfpweXEQCaU/cSUQ3At3MiJQt2DcC5sGzpskRjaDvjuNhV3vG5
	 BegQJHRNGJ59ocpzb/UbLmhFvM6KVGIZ1poDnVkzWlij5XbukRWorvucLvVJkqa5HG
	 hGxerQFd58E7/X1XZi9/7xfznMbhiXcZWtc7z0jwPrzdgjdKAdViUYJvlPraIvFsYE
	 2/qLQXFlaM9FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Yunxiang Li <Yunxiang.Li@amd.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	peter.griffin@linaro.org,
	andre.draszik@linaro.org,
	jyescas@google.com,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v2] dma-buf: remove unused dma-fence-unwrap.c (stable/linux-5.15.y only)
Date: Sun,  5 Jul 2026 09:51:58 -0400
Message-ID: <2026070416-stable-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703-5-15-dma-fence-unwrap-v2-1-43d58ee68c6b@linaro.org>
References: <20260703-5-15-dma-fence-unwrap-v2-1-43d58ee68c6b@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2026-07-03 at 14:28 +0000, Tudor Ambarus wrote:
> The file drivers/dma-buf/dma-fence-unwrap.c was incorrectly added to
> the 5.15.y stable branch in commit 4e82b9c11d3c ("dma-buf: add
> dma_fence_timestamp helper") as a new file, but it was never enabled in
> the Makefile, and its header include/linux/dma-fence-unwrap.h was not
> present, making it uncompilable.

Queued for 5.15.y, thanks.

-- 
Thanks,
Sasha
