Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640546;
	b=WVG2+L9yGyy2TzQg2pWKiPJQ//kjHFWwk/+iiz5pTA/l1q+EZa7F6P3H4FnmgCGX7I0K
	 MJSlhSPyvv+C33kFDpjY1OR6xNa96TwpE47uAnCC16nXFTTkA6JbBSK1HFLm3x+02ojjL
	 Z0EKlDnfqLfgJym7Bc2yDA3soNHlaR75O7Yyy0DoGMbAcEXOdlEe0NEKhz/0icm/VNhc0
	 YreBu64bv7NKXU6LIBhhvOJtsKA4IeANGHwS3t0mB5JRWsrd1eXZaobroeQeQqnFFkbdN
	 SSwmw3fo0Tuc5FUp2G289nZ5WhBD62oL4ZmMQIVyItQnc0IKIhcmQJ7WtP+w8uAo0YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640546;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=P9QOz6y3xfqVjgcaci9v480+CGZcm/1tKOJFlnBqKrw=;
	b=DCsRDNih2l4P9/CJpYx5Lz66HKhfPwu9O+LCLTZk9jlZQMM3a+rvs+R2v8lfhGIk3Xgb
	 /xezDFbKRzrGCh/LlZNMnV9QLtKqICJ2sHAkdX1Nhg1e9CXBnGwx/IVyYSEg84XvJbxIX
	 CibT9eZhk9clRsLlE4ujOElAucHYESoFWr7/31CGAC2S4GrJsumgF5glrZT+I9cO5ekpp
	 25Nv14Y0ttBB/KXQ912xEvya72rp5G7SnoM0hKgqDEQ1ASZjEoRbmoDM18jGoul5VC6e6
	 A+DX/keENtTMlzttal0KRKjps55UPwAPNy45B7iAHvdigbwGAAHu2/b2UyWXxFOtahw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZudVGusq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD3606E028;
	Mon,  2 Nov 2026 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZudVGusq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6FC1F00A16;
	Mon,  2 Nov 2026 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640546;
	bh=P9QOz6y3xfqVjgcaci9v480+CGZcm/1tKOJFlnBqKrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZudVGusqLYGAx/e8LMaMBzz7M6KkTZ78umyHo4OiN9jvTnmgkfRa1+z4UkCPRJFb2
	 bC6XoRVhIwzAxjZujKBKTDGS8UxYGY/3FAI/hAnMVkRgROjBAS9cBe+d5+aG50hCuM
	 Q15V6hTCqgpJrlJsUvvdcfrNJkbA7NYJrY+gfSWqT7mIPIwseV4P17OnQXe4j30822
	 BWn66180U50nNi1QTXJ6RT6NFAM9KphUql29xB5YKKKHeI1fqLw3K0CyobZG1rAxEW
	 X34/qdz6lU3IqtXVFpt55mBs2tQ1AfDU590+VkVZu2epRTWa8gR5KmN+ZeIKBsz7XK
	 TzQpY1UnRsSHQ==
Date: Mon, 2 Nov 2026 10:29:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yuqiang Sun <izaiahsun@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, john.garry@linux.dev,
	nilay@linux.ibm.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: Do not drop the cdev reference twice when
 cdev_device_add() fails
Message-ID: <aujIYJZvZzJrTrne@kbusch-mbp>
References: <20261102095015.36448-1-izaiahsun@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102095015.36448-1-izaiahsun@gmail.com>

On Mon, Nov 02, 2026 at 05:50:15PM +0800, Yuqiang Sun wrote:
> Since commit 9952f3882ecb ("nvme: fix cdev lifetime"),
> nvme_add_ns_cdev() and nvme_add_ns_head_cdev() take a reference to the
> namespace (or namespace head) before calling nvme_cdev_add(), to be
> dropped by the char device's release, nvme_cdev_rel(), and drop it
> themselves when nvme_cdev_add() fails. But when cdev_device_add()
> fails, nvme_cdev_add() has already put the device, and nvme_cdev_rel()
> has already dropped that reference: the caller drops it a second time.
> 
> With one allocation failure injected into cdev_device_add() for a
> namespace on an NVMe over loop controller, deleting the controller
> gives, with native multipath:
> 
>   BUG: KASAN: slab-use-after-free in nvme_put_ns_head+0x21/0x140
>   Write of size 4 at addr ff1100000a4ea078 by task init/1
>    nvme_put_ns_head
>    nvme_put_ns
>    nvme_remove_namespaces
>    nvme_do_delete_ctrl
>    nvme_delete_ctrl_sync
>    nvme_sysfs_delete
>   Freed by task 1:
>    kfree
>    nvme_ns_remove
>    nvme_remove_namespaces
>   refcount_t: underflow; use-after-free.
> 
> Take the reference in nvme_cdev_add() instead, right before
> cdev_device_add(), and let the callers neither take nor drop it. Add
> nvme_is_ns_cdev() for the check that nvme_cdev_rel() and nvme_cdev_add()
> now share.

Thanks, applied to nvme-7.4.
