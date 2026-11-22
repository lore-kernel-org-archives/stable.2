Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795351638;
	b=SuPlAeMyMs26NevvXKC1Qtqz/Egzq1NUthjCOdEFi6TKrqAp6nawlq/LIhSaJIqqqt7A
	 SLgIWrHWaLcwmoarvTV8EFyfq5HRn9mQo8mNKBmaYk0ZvIJ7IN3N7wkW8vgGfxptoCgX6
	 c/zaNDKA+jH17gx7eX3wuVhnGEhoMqYzUEobuT2Uer8OJlDup5plryykkhpkQ4P7ib27O
	 MmIf2EZamJOck1XZaaMTh+WBGj4OAjkPf6pPVH5HA5W/wiSsU6BcrxH5SIG6ULRB5+qqF
	 0EPBG4UJEoJ5B1VnGE+ntw4MVqs0c2CX9kV1fSJ0gJSybLrW4StcZTWs2dVIsIshrSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795351638;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H6i7jKklZYNYidCp2oakstTLRi6a7yVcN/iUSHiKrp0=;
	b=iwHD5O6iwhCvI3ySPfzHSIj6fKGdpIoL4D4vbpiU5Igid8p3kJe9UTnFZzzy8KKFjZ2r
	 SUnSF25NzhDl0GrgB3bghaOksLbHyBKV4MNRn30K4ye3Xpal7sEZhxELpPyC/2W16DEaY
	 6tprEw+KOb5oGR2R2+NmUOkPhCT92/9jcnXWhpySCSvpcGBYG9OZVegjJ3xFM664qHZJU
	 hlQ/GcPByh8iBcwwuow4/RarUyqF0oMwSPIZCYPSJFgHZ0nZXBUWwyver2/LDBAUVi0zn
	 SMqmge3ZMI/b2Msg8RTDXo4bUIQ6kse+uyMbuKjzJuEpUX/f5oO+4tpw0WR6+EUlVuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xd6hb4qM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3070606A320;
	Sun, 22 Nov 2026 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xd6hb4qM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795351637;
	b=bcN3wPd7/kxRdjO9UvdZlOUF86JJioRiyUjRfcptuoudgty/NRfAqsRh8ePD6VgZDF3J
	 SacLuXD5Z/5wD5VOvCXsg7TnWlHU+aA8FCIdKoZdYpBph0uijm8eaXuCYWpQ64VBkVLB0
	 btPGjAljjpLwVcVmzd2Te0qiHbS6nOvRBFTYQXo8gkMzAGyjWlqHIsSiB/IML7jSQbG7V
	 4b1VDTCkvu6XIlxqchofD6Axz9HcYASZEuqoBrFdaaEhI0U4drI1vOrujlBVHRZv7yJTO
	 XfQP/9ncBGg0cXluvPtkniHBT2yo8x13Gp4ptacBDFcLMHzZ8V7PDbLC6wHX53vGWPA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795351637;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H6i7jKklZYNYidCp2oakstTLRi6a7yVcN/iUSHiKrp0=;
	b=Cy/tT7ccfY6HVF2Xaemp5uLaQJnMnIjx1DRUh9GZlSu/+7mQCeGD2SgPxhtMJ7FYvy+A
	 mWDD/wwq9+hRrg1hNCxDlm8YKxNkZPFlY0ygJlln/tsZ7MyGiqrKXOWOvZ/O2VON2WxFk
	 t4iHBQK++nMtfjs9R8khdpv22vcA90SNnXFRQSN6yxEw1nEsUT/jvc7Y/4IoYnqdJ3yhk
	 7LXCgwGZrEASTFmctYaEQlJDZnQQF4lhusOM63sBgMBEk/v+qepm1fInQD7Xi1PJbqgQK
	 mg/S9LNKqj+ZPBp546ozqLfMLwrrqqvI2DQuCQ3Fvbmu1pvXrgy8HlaXKQeovHbjLwA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 848211F000C0;
	Sun, 22 Nov 2026 12:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795351637;
	bh=H6i7jKklZYNYidCp2oakstTLRi6a7yVcN/iUSHiKrp0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Xd6hb4qMUki8cwX0QTgsO7SkaaZAg+PwDSPle8+feCvfk2c2nE0te4QalQEtT/gt8
	 YNt0n+A90hfrC5LoKXbQTLhskxtOfWEEztqemvRmri3NNuuRzopV10LC9ffMsqF0j3
	 Ytl0PYxYms0uwhfuDSDoy9kcTMnn3CW4Ucbm8mfm+BSSGeH5QAn/W91OsKwq4exFgT
	 KQiw5nEQ2swYPs0pBXEiglb1cYXIW4fUt+kgZkvTHzZFo2mJVKw5JQJaFEWxawPqDC
	 fnlhe9bC+P8xSg9bh1FYjGrGcmqwzD8mxU3C4liZiCBv9DSLTYfOUr3nyB9cnLVYki
	 /fW0KMqcIWBLg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 11F2C4C034;
	Sun, 22 Nov 2026 12:47:11 +0000 (UTC)
From: YanXin Li via B4 Relay <devnull+fadouse.pm.me@kernel.org>
Date: Sun, 22 Nov 2026 20:46:37 +0800
Subject: [PATCH v2] iommufd: reject mmap() of not-yet-finalized objects
 with iommufd_try_inc_users()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-04-iommufd-mmap-uaf-v2-a67fd4229347-v2-1-5c108f208c89@pm.me>
X-B4-Tracking: v=1; b=H4sIACzkAmsC/yWNQQ7CIBBFr2JYOxGGkVavYlwMMCjGtgas0TS9u
 60u38vP+5OqUrJUddxMqsgr1zz0C+B2o8KV+4tAjgsr1OiMQQRPoAny0HVjitB1/ICRE7wQ2DU
 pEuLBUgMcvY4m7Y0JWi2xR5GU37+j0/nPdfQ3Cc+1vi48VwFfuA/XVRW58wdWuQtERlOyjjByg
 9o40oQOrVBrsbWOJcXYiprnL5okshDQAAAA
X-Change-ID: 20261122-b4-04-iommufd-mmap-uaf-v2-a67fd4229347-adb0d1f511c0
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795351630; l=3039;
 i=fadouse@pm.me; s=b4-relay-20261122; h=from:subject:message-id;
 bh=Z84dv3tFgdoJmnVouiJISUeePaqORmrrqKd4RPqN3QM=;
 b=ToN2PGJXB+5WFnyUW173WnInnUMjF3W3Cd1ZCMQzK9yMGN309zX2gytW39ZMzuE0oIp/aITtJ
 dHH8X6KtIzjATSBu6TXFoRlCD19Gp5zoxCKN65pYAa+fdkUvgcFd4ZG
X-Developer-Key: i=fadouse@pm.me; a=ed25519;
 pk=b4DyzHJDRd8853IHUSKPA5wwzChj8eF4MTnZuyPz1PQ=
X-Endpoint-Received: by B4 Relay for fadouse@pm.me/b4-relay-20261122 with
 auth_id=1597
X-Original-From: YanXin Li <fadouse@pm.me>
Reply-To: fadouse@pm.me
Content-Transfer-Encoding: 7bit

From: YanXin Li <fadouse@pm.me>

iommufd_fops_mmap() pins the owner of an mmap region with
refcount_inc_not_zero(&immap->owner->users).  This can also pin an
object still being constructed: IOMMU_VIOMMU_ALLOC publishes its
immap in ictx->mt_mmap before the object is finalized, while
ictx->objects still holds XA_ZERO_ENTRY and obj->users is 1.

A concurrent mmap() can take the reference.  If the creation ioctl
then fails, for example when iommufd_ucmd_respond() faults on a
read-only command buffer, iommufd_object_abort_and_destroy() erases
and frees the immap.  iommufd_object_abort() warns about the extra
users reference; a later VMA close dereferences the freed immap.  On
the unpatched kernel, a CONFIG_IOMMUFD_TEST reproducer reported:

  WARNING: drivers/iommu/iommufd/main.c:126 at iommufd_object_abort
  BUG: KASAN: slab-use-after-free in iommufd_fops_vma_close

The reproducer needs no hardware IOMMU.  On production kernels, this
requires a driver that publishes an mmap region before its creation
ioctl can still fail, such as tegra241-cmdqv on real hardware.

Use iommufd_try_inc_users() to check under the objects xarray lock
that the owner is published before increasing users.  It returns
-EBUSY for an unfinalized object, so mmap() returns -ENXIO.  The mmap
path takes the objects lock under the mt_mmap lock; object teardown
releases the objects lock before erasing the mmap entry.

With this change, a finalized viommu can still be mmap()ed and
unmapped.  In an x86-64 QEMU/KVM guest running mainline after
v7.4-rc3 with Generic KASAN, UBSAN, lockdep, and DEBUG_OBJECTS, 3000
aborted allocations racing two mmap()/munmap() loops produced no
kernel splats.

Fixes: 56e9a0d8e53f ("iommufd: Add mmap interface")
Cc: stable@vger.kernel.org
Signed-off-by: YanXin Li <fadouse@pm.me>
---
Changes in v2:
- Resend via b4 because the archived v1 email gained a blank line in
  the diff context and cannot be applied.
- Shorten the commit message and correct the tested kernel version wording.
- Link to v1: https://lore.kernel.org/r/20261122032416.11746-1-fadouse@pm.me

Test baseline: c44104f3642d
---
 drivers/iommu/iommufd/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 9a921b15316..f0b4308fe34 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -601,7 +601,7 @@ static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
 	mtree_lock(&ictx->mt_mmap);
 	/* vma->vm_pgoff carries a page-shifted start position to an immap */
 	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff << PAGE_SHIFT);
-	if (!immap || !refcount_inc_not_zero(&immap->owner->users)) {
+	if (!immap || iommufd_try_inc_users(ictx, immap->owner)) {
 		mtree_unlock(&ictx->mt_mmap);
 		return -ENXIO;
 	}

---
base-commit: c44104f3642da720164042623e4832836aefdd8e
change-id: 20261122-b4-04-iommufd-mmap-uaf-v2-a67fd4229347-adb0d1f511c0

Best regards,
--  
YanXin Li <fadouse@pm.me>


