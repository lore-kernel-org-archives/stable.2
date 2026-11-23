Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468233;
	b=RXSbqTk20Gz+vUBederSXUnFu3rtziCjbQEwoF6VsyTdvxWnQsYT41GyR6H4i7qp7UDC
	 QShAuW5dErWJ6zQtWLiU0zc4bGOP6cpDRgF1+Zfq0jOweE/KgsA17awqbmBdJOwZvLHm7
	 PFiAtNygnPZV4d457128BhJw+83Pu35vhB50IWKogBHHqOlwDzvIQNWHxfaSHwgTxEbtk
	 4qqkGwCELNsbChhsL0vLhrLxiZg2ZaLmyVauXQ/BGOX+qBE/6iN/y49egb3+Fg9fJEoBN
	 ZoammHUVH/wcQK2Chs58oMb7pXTRK5Uo2Tzz1Vi4kfManCDp86JCKvMzZt1aXSEmYKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468233;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=iX6MuWhP33XWsuDSuSQNpNGzCYftx0+GiYKlrEvhO0M=;
	b=kSUjKqbPAu5DC8ZHOGktK/ws18BJzjgdnZjEdb5vdLdWk0mG6seoa1X4Ko/D6puVXGaC
	 j32cC9vHoy/kdjUa0LEpwgeCA573CbWH7omj0Yn+Qz31fC3jbDANBQNfb6OkU1thk724/
	 Kro5w7X4y/GMjdmv3J3/WgkYlXEgoV0FpkouLZzf9lT6wRcdyq14AOLVtlVMMOYmJ/J55
	 esANOu6xyJKR2+XsXMTW9X74G4Hsgs/Hc66/VWIQw2zYaI/QIQOU1bSm5rrocPZqER7MI
	 E4DXR9q0X4T3XAlapLnvGnK7zpBa73DEvE6MFU4nDqLfNFnBqjUnp83EqPbXjz4wumg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="rNHoxML/";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC83606A32E;
	Mon, 23 Nov 2026 21:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC83606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=rNHoxML/
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.167.112.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1B21320B7167;
	Mon, 23 Nov 2026 13:10:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B21320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795468228;
	bh=iX6MuWhP33XWsuDSuSQNpNGzCYftx0+GiYKlrEvhO0M=;
	h=From:To:Cc:Subject:Date:From;
	b=rNHoxML/I5i10pltcG6lX6ieJNUXGb3daW/UlhQu0qN9Kos+ZnzWnucJH6vS2wbDl
	 LxC8nFhAhvGL1uDWg+Oe+NnVVEh/U+jCpHL4XOocNgoP8iJ8KmDJIDTh5Y7dgaYsk6
	 pv+UJpdEPxP057cf6rUqYmp98xb+JkSElBGaCFqw=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] vfio/container: hold group_lock across backend ioctl passthrough
Date: Mon, 23 Nov 2026 16:10:25 -0500
Message-ID: <20261123211025.485602-1-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
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

vfio_fops_unl_ioctl() forwards unrecognized ioctls to the IOMMU backend
by reading container->iommu_driver and container->iommu_data and calling
driver->ops->ioctl() without holding container->group_lock.

When the last group is detached, vfio_group_detach_container() takes
group_lock for write, releases the backend and clears both pointers.
An ioctl running concurrently on the container fd can therefore use
backend state that is being torn down. With the Type1 backend, a
VFIO_IOMMU_GET_INFO racing with the last group detach walks iommu->
iova_list while vfio_iommu_type1_release() frees it, and faults on a
poisoned list pointer (dead000000000100).

The other container entry points that use the backend, namely
VFIO_CHECK_EXTENSION and VFIO_SET_IOMMU, already take group_lock.
Do the same for the passthrough path and hold it for read across the
backend call. This is consistent with the existing lock order, as
backends only take their own locks (e.g. iommu->lock) below group_lock.

This patch was developed with the assistance of GitHub Copilot CLI
(Claude Sonnet 5.5), which helped analyze the race, draft the fix and
this description, and build-check the result. The author reviewed the
change and tested it on a downstream 6.6 kernel.

Fixes: cba3345cc494 ("vfio: VFIO core")
Cc: stable@vger.kernel.org
Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
---
 drivers/vfio/container.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vfio/container.c b/drivers/vfio/container.c
index 003281dbf8bc..38ef3b3dd0de 100644
--- a/drivers/vfio/container.c
+++ b/drivers/vfio/container.c
@@ -346,11 +346,14 @@ static long vfio_fops_unl_ioctl(struct file *filep,
 		ret = vfio_ioctl_set_iommu(container, arg);
 		break;
 	default:
+		/* Keep the backend alive until the ioctl completes. */
+		down_read(&container->group_lock);
 		driver = container->iommu_driver;
 		data = container->iommu_data;
 
 		if (driver) /* passthrough all unrecognized ioctls */
 			ret = driver->ops->ioctl(data, cmd, arg);
+		up_read(&container->group_lock);
 	}
 
 	return ret;
-- 
2.43.0

