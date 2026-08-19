Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8C3A83AC
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157974; cv=none; b=bnczFPuFEw50tsyrrLBRCd7ih0fCp6klVKAgQCq6yHy96RUg9puS6Hqo3mt7yIYTv7f+fUyU1c+I4WANlQytHWli3ADWIZ7sDA/cZPAjc07V9H/zglY2Uo8uJkVkdQgaYNbaCIimov45Qsl6RlVeinjxrvaN11A+iWDSC8t5soY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157974; c=relaxed/simple;
	bh=IdAftmlo+mRu7lXc9MDZJxVDs0JaB7Zc6ukdt6z39t0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z3rhXMIYoiQLus5lfICSbxE35nwXbrnmpQ6VpWxcvfghansYJHvpL2w21/AFVMYnGq6h87LT3j0ZH6fR5ZjpXvhnZjLFpv8+WDI6ZzRU5dEVJ9pT84OpbJxHrYVZCtTaiQ56B8eEHS0DBrNa3qxSwDkSDdDJAPHNLGF6AOaq1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1tniGuO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sGi+kDMl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1tniGuO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sGi+kDMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787157971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kKB6a7tb48I7KIcMKOrkf8BWQaXL7teAC4Q0HqgLOxc=;
	b=E1tniGuOWEbK1FXcqnO5jtVuBIBaex/nTrlriDu5RN1lukqzFfzlcTLg71DG9u24c006H5
	GOpfpTakc9etaOPvyhOy7lNR6iW7y9xRNpVpQ3OSAD809Hbt8kBi+/Iy5Vcg4zUTT2+UC7
	AOXdUdA9NfC0XQinraSFCQOYp4tRRyg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-J9dm_qZZPtaR7e_GmsuHrg-1; Wed, 19 Aug 2026 12:46:10 -0400
X-MC-Unique: J9dm_qZZPtaR7e_GmsuHrg-1
X-Mimecast-MFC-AGG-ID: J9dm_qZZPtaR7e_GmsuHrg_1787157969
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f2de3ba47so863064f8f.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787157969; x=1787762769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kKB6a7tb48I7KIcMKOrkf8BWQaXL7teAC4Q0HqgLOxc=;
        b=sGi+kDMlFQVRS/zHCX4A1RpSPfU4AgmiZZhvO8YH6jUH1Oe/J5o7vdZ6ACh10l8dIO
         BUg6Dm7FxHv3SKMn9u+dMCS/ALMT73Sy30PCXuK9WTenzjeknhxJCuUfNmXgX100sLtj
         znuAlb04tHh8oVwL4qn+wK16cTbTEJkGqJcLMYa0FNQWfpUzEbP84hukoKQoBr27ZuX9
         MqIj1AOcVzhcx83FLGQTrBHEasCOWGub4IzWl/3ioHKF0bx2lnN2MTm4KQL862vGhUSA
         qXKEK754HrgssHclc1qE/0qsKqPBX4oK8W7FoB9iYykgMRePt2oCpSl/mUw1EkU5fhUm
         l5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787157969; x=1787762769;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kKB6a7tb48I7KIcMKOrkf8BWQaXL7teAC4Q0HqgLOxc=;
        b=rj1PQOeikYbPSVY325GrMkfRX8GbQElFGuR7VPbuxUJEL4FLPtuOfhsXpohpMGQNgP
         hoobRzBEz5IgOwUY2s5SwKxfDMtVfmVEEdqd/wbNwL6kj/4r0Wo5VrqhIspvKMfqDoua
         loetV4h4bTMD45gykUmr4tuP0mU079uHuO5Oys8i5hhMBAM/675jjJQpGpCxlloUl66U
         isng6ZrepR1K8DzLs1i9xSMEkMI7STJjSSpvo6M/PrDz/6tWkjfBBVkF0NAvZhrVZ+SK
         +Hku0IwwDQXuVDv5WBXXMm2EeWes5nfi/+pjff97Rbcah0amB4LQM1eEwd35yKQot/Q4
         qrTA==
X-Forwarded-Encrypted: i=1; AHgh+RpbCJhquyEvpSRLQUqyf1ES1pkCmT5mrqLXANK5tDU/sRNiw1+UKafpDR4uVdvmG9Nd8gLnBn0=@vger.kernel.org
X-Gm-Message-State: AFuF++lp76aOIAK3aS2HaftiaFYb58CEAmv01G70Dn5oX8582IyAkrIo
	tJdMkUC3qhEGhRTuQv0Z6zKzrY6vGrtnZFcxES54qNfGv7q/VB7EIl0wJd5rwLFuYMdY75YSZqz
	WOQlVZD5q+bAAmUBJP7QhVbovEVqcM8mu8HFIZ8r1G5M93U2s+bpHalzIRw==
X-Gm-Gg: AR+sD13wymx3fk+yFP7w65AkkrJCHbdmL/6GoL9TgRTsM3JRNT+FUDQpR4ZqgfgvdPl
	XpctUj0/KoNTvLKcQB7Tk1rsgY/iJKRNpmXXC6tJezFrvB/fsDDCNtzvPz4+Fa6LWBYN/ELNeW0
	TghQ+F/o83R2bvmndVaLTBFaqjGvjqhL/eO8cyfTmaiTGU186tJccFsnPcvVq+RhmWnW5uaEuAO
	/p8MEJ95RUazYQHK3sKD1xUWHWmcqoAPbHzySdPr/DXutWeEHG6fG+RmdPrWUesx9gFly0pGOLn
	ILXKmL5OA0kG1tCf5DCUcDOeeNi87xXV9KRYaT7GH6CpMyDubBAc2osdJARUxId1HH2dD1Ro0iV
	NxeVCxcxPAF3+fJuoJKYyKwE8
X-Received: by 2002:a05:6000:1445:b0:47f:8b24:ef01 with SMTP id ffacd0b85a97d-482b1e837ddmr10403273f8f.1.1787157968660;
        Wed, 19 Aug 2026 09:46:08 -0700 (PDT)
X-Received: by 2002:a05:6000:1445:b0:47f:8b24:ef01 with SMTP id ffacd0b85a97d-482b1e837ddmr10403179f8f.1.1787157968144;
        Wed, 19 Aug 2026 09:46:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-107.inter.net.il. [80.230.47.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c45f1sm6670328f8f.31.2026.08.19.09.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:46:07 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:46:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	aesteve@redhat.com, ben.dooks@codethink.co.uk,
	chenyichong@uniontech.com, david@kernel.org, den@openvz.org,
	eperezma@redhat.com, gsomlo@gmail.com, hexlabsecurity@proton.me,
	linfeng.sun.dev@gamil.com, lirongqing@baidu.com, me@linux.beauty,
	mst@redhat.com, panchuang@vivo.com, pankaj.gupta.linux@gmail.com,
	pengpeng@iscas.ac.cn, peter.hilber@oss.qualcomm.com,
	sgarzare@redhat.com, stable@vger.kernel.org,
	syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com,
	tavip@google.com, wangyufeng@kylinos.cn, xiongweimin@kylinos.cn,
	xiongwm2026@163.com, yangjinqian1@huawei.com, zhaoguohan@kylinos.cn
Subject: [GIT PULL] vhost,vdpa,virtio: fixes, features
Message-ID: <20260819124604-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent

The following changes since commit 8d3ae59288f1e7d58d76558a6ee96d533bc5019f:

  Linux 7.2 (2026-08-16 14:32:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to b282418bc366194677eafd1dad180d92254586ac:

  vduse: Add suspend (2026-08-19 06:38:48 -0400)

----------------------------------------------------------------
vhost,vdpa,virtio: fixes, features

- transport v3 support in virtio-mmio
- suspend support in vduse
- fixes, cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Albert Esteve (1):
      virtio: Add ID for virtio media

Ben Dooks (1):
      crypto: virtio - fix missing le64_to_cpu() conversions

Bryam Vargas (1):
      crypto: virtio - bound the akcipher result length

Denis V. Lunev (5):
      virtio: add virtio_device_shutdown() helper
      virtio_balloon: factor out virtballoon_quiesce()
      virtio_balloon: quiesce balloon work before device shutdown
      virtio_balloon: warn on failed buffer add in tell_host()
      virtio_balloon: warn on failed buffer add in stats_handle_request()

Eugenio Pérez (6):
      vduse: store control device pointer
      vduse: add VDUSE_GET_FEATURES ioctl
      vduse: add VDUSE_SET_FEATURES ioctl
      vduse: add F_QUEUE_READY feature
      vduse: do not take rwsem at reset work flush
      vduse: Add suspend

Gabriel Somlo (1):
      MAINTAINERS: remove Gabriel from LiteX and fw-cfg drivers

GuoHan Zhao (3):
      virtio: rtc: time out alarm requests
      tools/virtio: Fix userspace typo in vringh test comment
      tools/virtio: Fix control typo in trace agent comment

Jinqian Yang (1):
      virtio_ring: fix infinite loop in virtnet_poll_cleantx when device is broken

Li Chen (12):
      nvdimm: preserve flush callback -ENOMEM
      nvdimm: pmem: keep PREFLUSH before data writes
      nvdimm: pmem: guard data loop for dataless bios
      nvdimm: virtio_pmem: stop allocating child flush bio
      nvdimm: virtio_pmem: use GFP_NOIO for flush requests
      nvdimm: virtio_pmem: always wake -ENOSPC waiters
      nvdimm: virtio_pmem: use READ_ONCE()/WRITE_ONCE() for wait flags
      nvdimm: virtio_pmem: refcount requests for token lifetime
      nvdimm: virtio_pmem: publish done with release/acquire
      nvdimm: virtio_pmem: isolate DMA request buffers
      nvdimm: virtio_pmem: converge broken virtqueue to -EIO
      nvdimm: virtio_pmem: drain requests in freeze

Li RongQing (5):
      virtio_dma_buf: fix typo in kdoc comment: get_uid -> get_uuid
      virtio_mem: fix hardcoded 'vm' variable in bbm iteration macros
      virtio_pci: fix wrong queue index for admin vq in intx path
      vdpa/mlx5: fix wrong list iterated in add_direct_chain error path
      vdpa/mlx5: fix wrong MLX5_ADDR_OF struct type in alloc_inout()

Linfeng Sun  (1):
      vdpa_sim: fix cleanup after worker creation failure

Michael S. Tsirkin (1):
      virtio_balloon: disable indirect descriptors

Octavian Purdila (2):
      iov_iter: export iov_iter_restore
      vsock/virtio: restore msg_iter on transmission failure

Pan Chuang (1):
      vdpa: Remove redundant dev_err()

Pengpeng Hou (2):
      vdpa: alibaba: add missing MODULE_DEVICE_TABLE()
      vdpa: octeon_ep: add missing MODULE_DEVICE_TABLE()

Peter Hilber (1):
      virtio-mmio: add support for transport version 3

Weimin Xiong (1):
      vdpa/mlx5: roll back MR update after VQ setup failure

Xiong Weimin (2):
      vdpa_sim: clear pending_kick on device reset
      vdpa_sim: hold iommu_lock across dma_unmap passthrough transition

Yichong Chen (1):
      tools/virtio: Remove unsupported --batch option from vhost_net_test

Yufeng Wang (1):
      vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY

xiongweimin (5):
      vhost: fix inaccurate kdoc in iotlb helpers
      virtio: fix article before virtio in dma-buf comment
      vdpa/solidrun: fix typos in snet_ctrl comments
      virtio_mem: fix typo in comment
      vhost: reject zero-size IOTLB INVALIDATE

 MAINTAINERS                                        |   2 -
 .../crypto/virtio/virtio_crypto_akcipher_algs.c    |   6 +-
 .../crypto/virtio/virtio_crypto_skcipher_algs.c    |   3 +-
 drivers/nvdimm/nd_virtio.c                         | 263 ++++++++++++++++----
 drivers/nvdimm/pmem.c                              |  53 +++--
 drivers/nvdimm/region_devs.c                       |   5 +-
 drivers/nvdimm/virtio_pmem.c                       |  65 ++++-
 drivers/nvdimm/virtio_pmem.h                       |  22 +-
 drivers/vdpa/alibaba/eni_vdpa.c                    |   1 +
 drivers/vdpa/mlx5/core/mr.c                        |   2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |  27 ++-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c           |   5 +-
 drivers/vdpa/solidrun/snet_ctrl.c                  |   4 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |  29 ++-
 drivers/vdpa/vdpa_user/vduse_dev.c                 | 265 ++++++++++++++++-----
 drivers/vdpa/virtio_pci/vp_vdpa.c                  |  12 +-
 drivers/vhost/iotlb.c                              |   6 +-
 drivers/vhost/net.c                                |   3 +-
 drivers/vhost/vhost.c                              |   4 +
 drivers/virtio/virtio.c                            |  41 ++--
 drivers/virtio/virtio_balloon.c                    |  51 +++-
 drivers/virtio/virtio_dma_buf.c                    |   2 +-
 drivers/virtio/virtio_mem.c                        |  10 +-
 drivers/virtio/virtio_mmio.c                       |  13 +-
 drivers/virtio/virtio_pci_common.c                 |   2 +-
 drivers/virtio/virtio_ring.c                       |   8 +
 drivers/virtio/virtio_rtc_driver.c                 |  14 +-
 include/linux/libnvdimm.h                          |   9 +
 include/linux/virtio.h                             |   1 +
 include/linux/virtio_dma_buf.h                     |   2 +-
 include/uapi/linux/vduse.h                         |  28 +++
 include/uapi/linux/virtio_ids.h                    |   1 +
 lib/iov_iter.c                                     |   1 +
 net/vmw_vsock/virtio_transport_common.c            |  13 +
 tools/virtio/vhost_net_test.c                      |   5 -
 tools/virtio/virtio-trace/trace-agent-ctl.c        |   2 +-
 tools/virtio/vringh_test.c                         |   2 +-
 37 files changed, 760 insertions(+), 222 deletions(-)

