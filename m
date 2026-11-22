Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795317885;
	b=H/CO+JBbfdDPEEVraR28j7L7lod4SQlBLb8YMlixYFPw2DTxPELWrG51qM3wpJIFOx2A
	 Hw65VGgZT9uTJ2nK6EucabM399KzuBMo5Vjrm9kaEkeRWP+aG48hme8vVm76baMNziSRI
	 Lvb93xbRg/fxCrzCFvB2x6Bsc4tE7KbQUvp8wK9rOYy1NmKXDFxTWtSNwXrRT+fL6WeGM
	 gl/8ZhAldrnbk3NkenArBvCNGPzlBUccEZlM5UfkiM6xLIZDJMkjIshnq20W/R09cQDHz
	 FW3g9YI0mQ89LLh9U3ytwOSixaVRFBuQEF7ra8YS80gII4v/9yOKlsQ4EXjCIJvU9WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795317885;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type;
	bh=dVPt2U6iq7crTwonEXwCqHbgHcYHeuHZoEUItSAFDoI=;
	b=1X8KZ+v6DbCVMalhKmmU/IANGlALxBrLGuzC/yDEpJ37F6JhtZTPtcJU++SGUoMoh2T/
	 YjZ6Hr2E7w4FY2uW4Joc1c0v0zk2a5GhJD5oJvPX1iFVF6gwTBWOiL6mHEswF5H7iCsbH
	 cHbIecCPmUl2ePNLcSJ+yXi5Auqc/krwQKhMyQOjrKSNeGR13TDLNu9uNvnIwXNb7wjBc
	 vSvw9zK1LROtyaoZIISwHOpPhHKBGK+1DiaHo1e3zQO4saGlsVM2OwRoCFUFPDGwOGzYw
	 MDfb237XkSCfznd6YN3DjaLUkEhNQZqJz39pH8l4rxVMYkIh6L/JFQ6u/5PZcUOMMiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=l3vLn20x;
	arc=none smtp.remote-ip=79.135.106.119
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DA7606A32A;
	Sun, 22 Nov 2026 03:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69DA7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=l3vLn20x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795317881; x=1795577081;
	bh=dVPt2U6iq7crTwonEXwCqHbgHcYHeuHZoEUItSAFDoI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=l3vLn20xUFeu9jF/KRmvIQs86+V4SnG0LWZG+ArD/SUr2koNT21BoGiWjq//Xe2c4
	 kuR/lYcAoEz4qD3ob9QhpexGQTdOZxqnowzHcj+sRXTZFC76bR7z0zhc6XaUrDvFU/
	 Pqxu38EgR40jzPi9FzJZIPQvi7lFyTs/Vxanvdc/g+p/3LmTcyANSlhinC5BO2DpXj
	 qTKcILTepan2kTHYmHTZqiqxto/ZjWwTMmBKDMuhShYoQCVdkeSJ0Is3a6ygdm4OL+
	 fixxURlgdKDVme/+TW35vCrpBbgi08tsoYccM8nd9LUp5A6El9E6cIIcNx2tNKMr6y
	 g0n9BCzRTSZGA==
Date: Sun, 22 Nov 2026 03:24:34 +0000
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>
From: YanXin Li <fadouse@pm.me>
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] iommufd: reject mmap() of not-yet-finalized objects with iommufd_try_inc_users()
Message-ID: <20261122032416.11746-1-fadouse@pm.me>
Feedback-ID: 173252840:user:proton
X-Pm-Message-ID: 2e3e86c516af680d0e6bb9a48ded81cbde7e0087
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------544810fc055904930d266b559413a1b51c21da378ff272b1e8f8d68ab6ef1309"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------544810fc055904930d266b559413a1b51c21da378ff272b1e8f8d68ab6ef1309
Content-Type: multipart/mixed;
 boundary=df0427a46fb63a2262dbaa451da7ca2ddf67cc09a6ce11258ecae5e89ad2
From: YanXin Li <fadouse@pm.me>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iommufd: reject mmap() of not-yet-finalized objects with iommufd_try_inc_users()
Date: Sun, 22 Nov 2026 11:24:16 +0800
Message-ID: <20261122032416.11746-1-fadouse@pm.me>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0

--df0427a46fb63a2262dbaa451da7ca2ddf67cc09a6ce11258ecae5e89ad2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

iommufd_fops_mmap() takes a users reference on the object that owns the
mmapped region with refcount_inc_not_zero(&immap->owner->users).  The
reference is meant to pin the owner across the lifetime of the VMA, but
refcount_inc_not_zero() cannot tell an already-created object from an
object that is still being constructed.

Objects with an MMIO region are published in ictx->mt_mmap by their
creation ioctl before they are finalized: IOMMU_VIOMMU_ALLOC inserts
the immap in mock_viommu_init() (or in a driver's viommu_init())
through iommufd_viommu_alloc_mmap(), and at that point the viommu is
reserved as XA_ZERO_ENTRY in ictx->objects and obj->users is still the
initial 1.  A concurrent mmap() on the same /dev/iommu fd therefore
succeeds in taking a users reference on the half-constructed object,
because refcount_inc_not_zero() only fails once the refcount has
dropped to zero.  When the ioctl later fails - for IOMMU_VIOMMU_ALLOC
this is reachable by simply placing the ioctl 
command buffer on a
read-only page so that iommufd_ucmd_respond() faults - the error path
runs iommufd_object_abort_and_destroy(), which calls the driver destroy
op that erases the immap from mt_mmap and kfree()s it, and then
iommufd_object_abort() WARNs because obj->users never returns to zero.
The next munmap() (or fork/exit) reaches iommufd_fops_vma_close(), which
dereferences the freed immap.  On v7.4-rc3 with CONFIG_IOMMUFD_TEST,
racing a loop of mmap()/munmap() against aborted IOMMU_VIOMMU_ALLOC
yields:

  WARNING: drivers/iommu/iommufd/main.c:126 at iommufd_object_abort+0x11d/0x1a0
  BUG: KASAN: slab-use-after-free in iommufd_fops_vma_close+0x87/0x90
  Read of size 8 at addr ffff888010f4a5c0 by task test_iommufd_mm
  ...
  Oops: 0002 [#1] SMP KASAN

The reproducer uses CONFIG_IOMMUFD_TEST and needs no hardware IOMMU.
On production kernels, the bug requires a driver that publishes an
mmap region before its creation ioctl can still fail, such as
tegra241-cmdqv o
n real hardware.

The kernel already has the correct helper for this invariant: main.c
documents that "the users refcount cannot be increased on an already
created object unless the object is installed in the xarray, otherwise
things are racing with a parallel destruction", and iommufd_try_inc_users()
implements exactly that check under the xarray lock.  Use it in
iommufd_fops_mmap() instead of refcount_inc_not_zero().  Before
finalize, xa_load() returns XA_ZERO_ENTRY instead of the object, the
helper returns -EBUSY, and the mmap() is rejected with -ENXIO while the
ioctl is still constructing the object; after finalize it behaves like
the open-coded version.  The mmap path now nests the objects xarray
lock inside the mt_mmap lock.  Object teardown releases the xarray
lock before the driver destroy op erases the mmap entry, so it does
not acquire these locks in reverse order.

With this change a successful (finalized) viommu can still be mmap()ed
and unmapped normally, 
while 3000 aborted allocations racing two
mmap()/munmap() loops produced zero kernel splats, versus the use-
after-free above on the unmodified kernel.  A test case and full
validation logs are available on request.

The vulnerable code is present in mainline commit c44104f3642d
(post-v7.4-rc3).  Runtime verification and fix validation were
performed in an x86-64 QEMU/KVM guest built from that baseline with
Generic KASAN, UBSAN, lockdep, and DEBUG_OBJECTS.

Fixes: 56e9a0d8e53f ("iommufd: Add mmap interface")
Cc: stable@vger.kernel.org
Signed-off-by: YanXin Li <fadouse@pm.me>
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
-- 
2.43.0


--df0427a46fb63a2262dbaa451da7ca2ddf67cc09a6ce11258ecae5e89ad2
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - fadouse@pm.me -
 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"
Content-Type: application/pgp-keys; filename="publickey - fadouse@pm.me -
 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuMTAuMAoKeGpNRWFVdU9NUllKS3dZQkJBSGFS
dzhCQVFkQXRuWWxTekhUTEhBMkl6dU5FMUF5OEpyS1VDeDZoUCsvdGM0TApEWENucmV6TkhXWmha
RzkxYzJWQWNHMHViV1VnUEdaaFpHOTFjMlZBY0cwdWJXVSt3c0FSQkJNV0NnQ0RCWUpwClM0NHhB
d3NKQndrUXVaMWd0K1htMlhSRkZBQUFBQUFBSEFBZ2MyRnNkRUJ1YjNSaGRHbHZibk11YjNCbGJu
Qm4KY0dwekxtOXlaem0wQnAzZUVYUldrbklnQ2xXd3ZkeFptbzFYblZiNkZrYWpYVFZNMUIvakF4
VUtDQVFXQUFJQgpBaGtCQXBzREFoNEJGaUVFbVVoYW8zWi9BbkJJNExCWXVaMWd0K1htMlhRQUFM
cTJBUUQ3OEs2cGVkU1gzbGROCnlxZDNPSDF1TWpPM3Y3TFlNaE8rbDdjblNMV3JFQUQrT0NTcTEx
U2VhS29ic1ZHckxlalRNc21Nc1BCOGpueGYKaWQzaENOK3Bld1RPT0FScFM0NHhFZ29yQmdFRUFa
ZFZBUVVCQVFkQXdYZHpWSXFFSC94OEhaalIvUE90MkFpRgpiRW02WXFYWDJqMnYyaUtEc1FNREFR
Z0h3cjRFR0JZS0FIQUZnbWxMampFSkVMbWRZTGZsNXRsMFJSUUFBQUFBCkFCd0FJSE5oYkhSQWJt
OTBZWFJwYjI1ekxtOXdaVzV3WjNCcWN5NXZjbWRkS05RWURGV2NFVmQzeE9IZVFwNnMKeW43OU5G
cE5xa0h6K2l6cElMQm5VZ0tiREJZaEJKbElXcU4yZndKd1NPQ3dXTG1kWUxmbDV0bDBBQUR6UWdE
LwpjSUowODlKa25vZ1RzNnZ2UVorSjNMUklEYUk5K1FtK1Q1cU9tTms0eVhFQkFMUElsSkNTOGFo
NWRCWVphOUwrCkhxamJEbWVTZ0RvNTh1U3graVd3KzZVTAo9TXVzVAotLS0tLUVORCBQR1AgUFVC
TElDIEtFWSBCTE9DSy0tLS0t
--df0427a46fb63a2262dbaa451da7ca2ddf67cc09a6ce11258ecae5e89ad2--

--------544810fc055904930d266b559413a1b51c21da378ff272b1e8f8d68ab6ef1309
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wqsEARYIAF0FgmsCYHAJELmdYLfl5tl0NRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfSSJlUeHcuM06T0RsZCl+sFiEEmUhao3Z/AnBI
4LBYuZ1gt+Xm2XQAABCzAP4ufnszD5yfuzsWM4JOVWnBiRJN9HsUyKJ4hAhX
KA1rxAD9HhV9XCyGFPT7vhWJb6Gbo3+9JFznDA49eqaMC5PtsAk=
=O0WQ
-----END PGP SIGNATURE-----


--------544810fc055904930d266b559413a1b51c21da378ff272b1e8f8d68ab6ef1309--

