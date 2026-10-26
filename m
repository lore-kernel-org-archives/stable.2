Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011881;
	b=QjS0+fjWYTOyPMkeTvubqeKcM13wxVY2fW/Cu47z5Nj3JmOunqE2AXkTS7/sxyVd0jeg
	 rBmORJTltacGrRUkfWDuYsDnkSNNWAj37jClLYDF9DZ3w3tj9tZHb4jMkjvN9RexAxfh3
	 PQjkPjtJGJNNBSTftaAf9wx/8DgMjglENUvF+q/iSfUwsMw98HExA3+tgLMniAfbTabHU
	 q4rmpy5EkTS8L3ddNycBEaKnWoy9i//h1Iy4YOOUSKzMtNvLgPzGzg/fHLOqpw1JoWoK8
	 cD5mTERjqiEyVZqFICG5R2qfzIRZoKtZ0FYYV1gd+l9hyXqfQYRNGBIAVVqq1SWNAzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QXblNSR8xULU+e1FuWNkvIygdbsQqdtYiPxZfiJKQg0=;
	b=Ti31L72PQ5aToPsfm9VJ05uJBElhIwHUzztEVWMD6bn/hI3HdPIUfuKlMk6MizHwtGJg
	 heZT71RrmWHE/flRT664KsnB7512BMAXLFmI54k2iwvlUmgCratwPTGUg0LcSvN55nSI7
	 nC8C1wDFuqn3krKUKy4BZGTjQVDyfx27dKezFOzpyVz0MNHZrGTOcl6X/KGAbC3mikAuN
	 Ffywg4Q06Lo9GCnsDeD6E8OPmng8a463MR3AcyOGcp1ie4fkKopk8uU++1yCO3fqceklG
	 +qR0bW7SAfrgt1xr/AkeZ6noZryfwAoCXe46PJTFkWck+OhXJfy4j7hrDVkzKAOTkhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qrw5sAsh;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB6606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50FB6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qrw5sAsh
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-188406bb948so2125378c88.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793011880; x=1793616680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXblNSR8xULU+e1FuWNkvIygdbsQqdtYiPxZfiJKQg0=;
        b=Qrw5sAshChMITFyQBNK3qy3rOjPlqRKLvy0I10a+jkUn8D1B3To+HKYWuYF2rGn3m7
         juWhgnE8SDB/Y9XsNhNk9BNJmcrr32JiEZ+3bOJ51hfSsqUSGdTrrMPvPJ3dNJxmk+KR
         LxmVAxcCtSOuF7OUIPU7cnx+gvsLnU4XGQDarjd4zGn4rYHquEMBBSeOfd43w8VyxUiq
         9yylOy2Qxz6JGtTdb0i3lgtNGdg5i5koFxqMLjDGxI7HgyNGRKEzgXIK272K0hbmWItQ
         73gmlT9YJDTna7Fnjj+daCsoq+8iSSTvCCvMLe5kSwQLgSRwQPB4JAHx7KgGI6YfVvIT
         K1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011880; x=1793616680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXblNSR8xULU+e1FuWNkvIygdbsQqdtYiPxZfiJKQg0=;
        b=An8qNx+JpJFII1Y15VoXIUWRra/7631eCuiqO4a1uuNRKZifCX0vaytDaZJjhFbB/S
         AGcUE5Sk1w5moIiECbziVXvRc2GKBfjE4w9BvhiNhUSfaksyEqTroscGK5i2pyXTi4L+
         TLmJQoe5gkHAuPf+b6dztf5wIftJXei+npkbxDfah9pCrfbYp6k3tP2uNQwc3MGZ2+wK
         BNDLCPWpvxJ92cG9UdQJcaA7Pd36Fp6BBiASG/xwz6edUYZ8kYGaVnZV4eX8ah7h4wT6
         aprb0IowHVAhVRJqlbjP/J+4+f9fUawzK1cleiOF72Eb5IzjjWiO8/VE6zndvhW1MtDQ
         a9UQ==
X-Forwarded-Encrypted: i=1; AKwUvBwq92OwHQELcb6czTW2E4zwvaO6aL+ZlBuQjDzpLUUb28NTwIg2Txe0J1VdLxK5JVzL00OWLNA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeM6CSL2V1ykCFVhmmt+t0OgHFRTtEcZmCvEqPm8SJfgPKeU/v
	YuIxPxiY20QxPhIwdtsyIM1mqv84ccyli1zcbeWhrvPEYnyaKOT3TzPB
X-Gm-Gg: AYBFou2/78JE60zte4t98kt1SAarSFamoWaBLUjESwxjvjVWXdC6rR6iqs0fIiGFO7J
	ASDjK0LZ37Je7KvvvQdAsgUgjAHQFZBRdmwGl8UgR6WMjcDxHpbLNT5GkvZu8JdG/9WGFuishGS
	KPLrVn6wCMbPvSiGGEzg5KU1P4mEAnyZ0EwMcUddZf9I/vyTqoFhQUeMpJwGTICydpYqtXCg126
	6IA2ZQx4Nebi52g/OqwLhyG1HkAG9NYKm/itagBp415249jY6fIgD3WtE4ckWjGSGM0vDBBRMGY
	DXryN9UzgWV+njEcQqMuf3/rugw/3JSimKieXcgNFRhqcBGdJlOFjbU8GRzfw516Roan/EXPRGj
	UtCkBSpRWbf/+Yvk6jGragDvGIX2PRzmEdhch7Rz5/3nJ5XR/0K95tnCOWv0Y98bq7KiNue7aSW
	BbOhy7rgM4tfp1fazyzztrxMD0tku4OZXll7is6wPniYRD8GOQ1D37ay1u1m201Sn4d1O66T+FJ
	JJaEDmGcJB9FSdXY+tj9UEi4bLO7Ffyzbu9k/s1rUH9yPqSlztmlaV9kInGjo8VrxcXcjDjtfsZ
	CUXl1uQWGVPkruoyO2mq
X-Received: by 2002:a05:7022:4387:b0:1a1:8974:593f with SMTP id a92af1059eb24-1a1897459a7mr3025660c88.30.1793011880275;
        Mon, 26 Oct 2026 03:51:20 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0e8d700sm27785940c88.10.2026.10.26.03.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:51:19 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: David Sterba <dsterba@suse.com>
Cc: Chris Mason <mason@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2] btrfs: remove devid kobject when deleting a missing device
Date: Mon, 26 Oct 2026 03:51:09 -0700
Message-Id: <20261026105109.1148939-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
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

btrfs_rm_device() removes the sysfs device entry only when
device->bdev_file is non-NULL.  A missing device (created by
add_missing_dev() for an absent disk) has bdev_file == NULL, but
btrfs_sysfs_add_device() still registers its devid kobject under
/sys/fs/btrfs/<uuid>/devinfo/<devid>.

When such a device is deleted, btrfs_free_device() frees the
btrfs_device while the devid kobject remains registered.  The kobject
is embedded in the freed btrfs_device and its show functions use
container_of() to reach it, so reading any devinfo attribute is a
use-after-free:

  BUG: KASAN: slab-use-after-free in sysfs_kf_seq_show+0x157/0x490
  Read of size 8 at addr ffff88801d8172a8 by task poc/9385
  ...
  Freed by task 9385:
   kfree
   btrfs_rm_device+0x11ee/0x17b0
   btrfs_ioctl_rm_dev+0x265/0x400
  Allocated by task 9390:
   btrfs_alloc_device+0x7e/0x400
   device_list_add
   btrfs_scan_one_device
   btrfs_control_ioctl

The freed object is kmalloc-1k and the faulting access is 680 bytes
inside it (offsetof(struct btrfs_device, devid_kobj) = 640 plus
offsetof(struct kobject, ktype) = 40), confirming the embedded
devid_kobj.

btrfs_sysfs_remove_device() already skips the block-device link when
device->bdev is NULL and only touches the devid kobject when it is
initialized.  Call it for missing devices too.

Link: https://lore.kernel.org/all/20261025180252.349049-1-teel4res@gmail.com/
Fixes: 668e48af7a94 ("btrfs: sysfs, add devid/dev_state kobject and device attributes")
Cc: stable@vger.kernel.org
Reviewed-by: Qu Wenruo <wqu@suse.com>
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
v2: add Link, Fixes and stable tags, keep the Reviewed-by because the code is
unchanged, and remove local validation details from the commit message.

 fs/btrfs/volumes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 85ea9c5..912a1ef 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2479,11 +2479,11 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 
 	btrfs_assign_next_active_device(device, NULL);
 
-	if (device->bdev_file) {
+	if (device->bdev_file)
 		cur_devices->open_devices--;
-		/* remove sysfs entry */
-		btrfs_sysfs_remove_device(device);
-	}
+
+	/* remove sysfs entry, including for a missing device */
+	btrfs_sysfs_remove_device(device);
 
 	num_devices = btrfs_super_num_devices(fs_info->super_copy) - 1;
 	btrfs_set_super_num_devices(fs_info->super_copy, num_devices);
-- 
2.34.1

