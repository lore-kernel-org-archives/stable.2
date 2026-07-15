Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96C417BC5
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110374; cv=none; b=n2+Pa+itR3bGyF8C2VFu7yQaA1VS2bZl57LUtERtWjuznzOkkfMyqXG/xieuySmJ7uCydP1yLpX3QYt7EbK0Qmxe4LYz71cSL7qHYnkgTduqIVWkODZyKocs2IsaOH+Tvr6MxM3cXi2XOhTumWhM2+VQqtWnu+egmVpworhHtD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110374; c=relaxed/simple;
	bh=HtVRDCCkqOEM/tmpwsrlzNe8ik14m99WWeqqS7YEix8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LyUj2R4vRUJVJaldTMZ2asJ/pzOO6xuxCDM1Q+Qe5jAdZRccDkDf5BZ1HnX/Qt+zHxCo9hadomP9+clyxDcx4LgYph/kezdo4pT+D9ZvWsyLcnSS32okrZ+Y4qVbEvPsKJ8FbIPepm+kUXpCzAb9qUTgSEmXBFhJu7GboQAEyAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oUK7TW/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oUK7TW/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280971F000E9;
	Wed, 15 Jul 2026 10:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110372;
	bh=kyTQZgpO9gZdkbINl7hkS20nklNCG5wStU354+yKozM=;
	h=Subject:To:Cc:From:Date;
	b=oUK7TW/XQd8un0Fc+gv3Z5m57UhPWlCfcDq9MklLIkcqSnfhfa8lzr/7bymwNCdr/
	 9vIcAdmqhB+AfSPT7QDYPMUdtd64R7B/pKHsQrWtPTX/m3XRibvfzz4kX0ON8ki0oe
	 aP40zDGiAY3zax3wzTYC/HvvMmZrCs0Us/KS9y90=
Subject: FAILED: patch "[PATCH] btrfs: do not trim a device which is not writeable" failed to apply to 5.10-stable tree
To: wqu@suse.com,dsterba@suse.com,fdmanana@suse.com,glass.su@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:12:38 +0200
Message-ID: <2026071538-darkened-frantic-7f72@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1b1937eb08f51319bf71575484cde2b8c517aedc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071538-darkened-frantic-7f72@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b1937eb08f51319bf71575484cde2b8c517aedc Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Tue, 2 Jun 2026 13:34:46 +0930
Subject: [PATCH] btrfs: do not trim a device which is not writeable

[BUG]
There is a bug report that btrfs/242 can randomly fail with the
following NULL pointer dereference:

  run fstests btrfs/242 at 2026-06-01 10:25:08
  BTRFS: device fsid d4d7f234-487c-4787-88e4-47a8b68c9874 devid 1 transid 9 /dev/sdc (8:32) scanned by mount (122609)
  BTRFS info (device sdc): first mount of filesystem d4d7f234-487c-4787-88e4-47a8b68c9874
  BTRFS info (device sdc): using crc32c checksum algorithm
  BTRFS warning (device sdc): devid 2 uuid fbe72d72-3272-482d-80fb-ab88ed398192 is missing
  BTRFS warning (device sdc): devid 2 uuid fbe72d72-3272-482d-80fb-ab88ed398192 is missing
  BTRFS info (device sdc): allowing degraded mounts
  BTRFS info (device sdc): turning on async discard
  BTRFS info (device sdc): enabling free space tree
  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
  user pgtable: 4k pages, 48-bit VAs, pgdp=000000013fd6b000
  CPU: 4 UID: 0 PID: 122625 Comm: fstrim Not tainted 7.0.10-2-default #1 PREEMPT(full) openSUSE Tumbleweed e9a5f6b24978fba3bf015a992f865837fdfff3dd
  Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20250812-19.fc42 08/12/2025
  pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
  pc : btrfs_trim_fs+0x34c/0xa00 [btrfs]
  lr : btrfs_trim_fs+0x1f0/0xa00 [btrfs]
  Call trace:
   btrfs_trim_fs+0x34c/0xa00 [btrfs f02c1d570ceea621c69d302ba75dd61868083840] (P)
   btrfs_ioctl_fitrim+0xe8/0x178 [btrfs f02c1d570ceea621c69d302ba75dd61868083840]
   btrfs_ioctl+0xdd4/0x2bd8 [btrfs f02c1d570ceea621c69d302ba75dd61868083840]
   __arm64_sys_ioctl+0xac/0x108
   invoke_syscall.constprop.0+0x5c/0xd0
   el0_svc_common.constprop.0+0x40/0xf0
   do_el0_svc+0x24/0x40
   el0_svc+0x40/0x1d0
   el0t_64_sync_handler+0xa0/0xe8
   el0t_64_sync+0x1b0/0x1b8
  Code: 17ffff83 f94017e0 f9002be0 f9402ea0 (f9400c00)
  ---[ end trace 0000000000000000  ]---

Also the reporter is very kind to test the following ASSERT() added to
btrfs_trim_free_extents_throttle():

	ASSERT(device->bdev,
	       "devid=%llu path=%s dev_state=0x%lx\n",
	       device->devid, btrfs_dev_name(device), device->dev_state);

And it shows the following output:

  assertion failed: device->bdev, in extent-tree.c:6630 (devid=2 path=/dev/sdd dev_state=0x82)

Which means the device->bdev is NULL, and the dev_state is
BTRFS_DEV_STATE_IN_FS_METADATA | BTRFS_DEV_STATE_ITEM_FOUND, without
BTRFS_DEV_STATE_WRITEABLE flag set.

[CAUSE]
The pc points to the following call chain:

  btrfs_trim_fs()
  |- btrfs_trim_free_extents()
     |- btrfs_trim_free_extents_throttle()
        |- bdev_max_discard_sectors(device->bdev)

So the NULL pointer dereference is caused by device->bdev being NULL.

This looks impossible by a quick glance, as just before calling
btrfs_trim_free_extents_throttle(), we have skipped any device that has
BTRFS_DEV_STATE_MISSING flag set.

However in this particular case, there is a window where the missing
device is later re-scanned, causing btrfs to remove the
BTRFS_DEV_STATE_MISSING flag:

  btrfs_control_ioctl()
  |- btrfs_scan_one_device()
     |- device_list_add()
        |- rcu_assign_pointer(device->name, name);
        |  This updates the missing device's path to the new good path.
        |
        |- clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)
           This removes the BTRFS_DEV_STATE_MISSING flag.

This allows the missing device to re-appear and clear the
BTRFS_DEV_STATE_MISSING flag.  However the device still does not have
the BTRFS_DEV_STATE_WRITEABLE flag set, nor is its bdev pointer updated.

The bdev pointer remains NULL, triggering the crash later.

[FIX]
This is a big de-synchronization between BTRFS_DEV_STATE_MISSING and
device->bdev pointer, and shows a gap in btrfs's re-appearing-device
handling.

The proper handling of re-appearing device will need quite some extra
work, which is out of the context of this small fix.

Thankfully the regular bbio submission path has already handled it well
by checking if the device->bdev is NULL before submitting.

So here we just fix the crash by checking if the device is writeable and
has a bdev pointer before calling bdev_max_discard_sectors().

Reported-by: Su Yue <glass.su@suse.com>
Link: https://lore.kernel.org/linux-btrfs/wlwir19t.fsf@damenly.org/
Fixes: 499f377f49f0 ("btrfs: iterate over unused chunk space in FITRIM")
CC: stable@vger.kernel.org # 5.10+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b20f5a887a53..624d76e0ca01 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6624,12 +6624,16 @@ static int btrfs_trim_free_extents_throttle(struct btrfs_device *device,
 
 	*trimmed = 0;
 
-	/* Discard not supported = nothing to do. */
-	if (!bdev_max_discard_sectors(device->bdev))
+	/*
+	 * The caller only filters out MISSING devices, but a device that was
+	 * missing at mount and later rescanned has MISSING cleared while bdev
+	 * is still NULL and WRITEABLE is still unset. Skip those here.
+	 */
+	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) || !device->bdev)
 		return 0;
 
-	/* Not writable = nothing to do. */
-	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
+	/* Discard not supported = nothing to do. */
+	if (!bdev_max_discard_sectors(device->bdev))
 		return 0;
 
 	/* No free space = nothing to do. */

