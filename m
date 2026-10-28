Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157956;
	b=Yh+rMkSn40w7g46CSQfWdqjRv43qDl++JWVtfb7B4TgLRXnL8xk9P3smG3TkP+1L2G7V
	 puVdWcaYh5cN+9JlikUZqDQYg1Vy9ka0wjrEdMlP4MO2XH7uTgfiZErD7ho9xyq00G5e+
	 nN287WYfkBVIQ2SrfdYu/SuxEONYIbsxVK9O7z52DPyL5N1obdmoSf+azg8a9WqjXDF6K
	 KF7xDNLNLk4m2doO016JxS6d7GbX5ya8/Q1OKSgqvSrNUA4X3ZkT5edAIH4kFzInBxQKN
	 v46ZXp8+zcke4FJMHd9H4CA5uXVWFgJBHkvoPgj3WIx4ijBzAZPZrL7PA4P8TGxQw2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157956;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=D28JZatR7tRBWGWn+V8up62pSIO1MfVbrWcwRfKoFko=;
	b=GEXUOa3Jk5grQsEM5A38qlJILSu9f7TNFZahlfg1ITSLkZLZL2SBqGiMx6eVI97pMLq8
	 TDKjoPUoWtJkjd4ex36NLy+m0rqFEUuw5mED/aiiGaVQEAR1I5Ey5LzgQwyU+8K2dDfXB
	 lTwye7rkfgEwpopEf78SmRqAUKhCzmdY56/nFSfW7v8A95tgfogxmRwPwKnsnjC/+4B9b
	 oBnNrnAh1KCXtrsg1NBZKTUvtHyml2uXIrw8JaRPaaVxkZf0fTlUnvrT6BJN0o6nJJk/6
	 O7kfM6/mHfAqEmsdQJawxSw8Otw1UkTbp70yRgTcFb/nninPj9oNwK3Wsvzt7VjB++w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xmkLNEo4;
	arc=none smtp.remote-ip=43.163.128.50
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5E4606A31A;
	Wed, 28 Oct 2026 03:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE5E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xmkLNEo4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793157947; bh=D28JZatR7tRBWGWn+V8up62pSIO1MfVbrWcwRfKoFko=;
	h=From:To:Cc:Subject:Date;
	b=xmkLNEo4wTXHuRD3F1b4TycsLbR2lMRxrckbazqcLG7HAGyY9byCDPzDi1ihK38ym
	 fhmRLs8w8QwFtSLuBswA0lU5Hgeomln46isUg15xndwRFjXpj06LMgLH53jAR7Fiyc
	 t9sIbM4Tgg1jnX+FcuOKUuM4UbNuMlJMD307R0ZQ=
Received: from CRASHEDROM.localdomain ([117.147.101.47])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 66D82CB3; Wed, 28 Oct 2026 11:25:45 +0800
X-QQ-mid: xmsmtpt1793157945tx3sarspn
Message-ID: <tencent_83B7D10D4DBCC6118AB6F6B83A509FFA5C06@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJfD2lEjmU2RCG47NAwtbr4geX27/x6qT/8eMQr6m+I5/KKD20KS
	 lQPJVDL/vX63eVQqcP9ADptWl5rbrJstDQfwFvf0oWQDo/+Ad5+s3xSbVNBWx1xb0zACyfJOkUtS
	 yt0wNHUnUnZlV1osI5T5sgftRzNGplGR4xUoEeYj61p0pMvLAHaW6n/6jVO/tLDz0tEJ1WIs3cqt
	 H1BRR/AYvIJJ2YJzvhnmSJFxj/DiEXuFTbqcLvxYJs7lR6+VlJopkmYRa99/LUGg+eE27PKrVjOO
	 80BeQbI97nzja88B+m0Ti9GLfu1NbVAO7/BVdpgaoZUrrbKJthNIGn9EuAXzI+kbwQ/Xs/BLc1ze
	 tqWjhjIeydivmx2Qab5njtlu11rzODeMI2PkYyp0HO4bVV/W0EdHQjKXu2Uw4kmGUbjoZqC46/dO
	 bLEeSk/0kdOl2HlKpJmzD3OiyhewHuQYHPL0jmzqvXo6m5cGEeWor4yIW9HYOBtBXyyy6FYzt5dT
	 OqCzhYP09cSyJ1S7MkGg4A/3SbiTyJfY5QDYx54Zl09JWdd1O6SnZry0AarWBARdogu5g8jXyVjr
	 6GvM7J4y1/pDk27yVIJjdEzID5vrDvUXL2rH3ht/tHccQokT8TZOvitvkUEPGaAvMcXJxfrRwLF2
	 1IJZtA12m+NSnD3KbqKOFqhIa1PCJQEp3plw1+3FFK0S2X8enyYgxPK3efoA4/Q6o0qdaJV1fUoD
	 y97Cse29kQ+E2i/eLMX7DJAQ2piJPtCzuyCRnS+k1mNV7pNV9Sry8CvUggi1td0DD/QA0KfR9EzG
	 5uFxxxWbJ223gJGZraDZsppIfwf6QS18AfA3ZjkgJLKQySVZAP80InmcT03zll+jW/NdkU1pxHlD
	 nOmTncoKn23yqgFmh/cuSyveQ/U6eF1h+e3TapKCZLKI6rqiX0Kcca7a3iKTFWeInn6rtxIUCVL4
	 h8qVGid8hL5G30BUJUO3TvW/ZWoqFvV5BnpZr3oUGnPKgd2hcWoPnOwE4u95C0Qi2oPM5VWmQ/Bs
	 695QyrixIIfD/1kS19TE3Q4nePcU+kqdrWqD35rmTZlRY5rIDYnkjqZo6dqLeVIMgKO6Py9w==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Chengyu Liu <19290937@qq.com>
To: khc@pm.waw.pl,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	Chengyu Liu <19290937@qq.com>
Subject: [PATCH net 0/2] hdlc_cisco/hdlc_fr: shut down protocol timers on ->detach
Date: Wed, 28 Oct 2026 11:23:08 +0800
X-OQ-MSGID: <20261028032310.2832307-1-19290937@qq.com>
X-Mailer: git-send-email 2.25.1
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

Hi,

While auditing the HDLC teardown path we found that unregistering an up
cisco or Frame Relay HDLC device leaves the protocol's keepalive/LMI
timer armed on top of freed state.  We confirmed both live on current
master with a KASAN build and a ~100-line fake WAN driver module (no
hardware needed): the orphaned timer fires into the freed hdlc->state
seconds after removal (slab-use-after-free in __run_timer_base, then a
fatal exception in the timer softirq).

Root cause, shared by both protocols:

  unregister_hdlc_device() runs detach_hdlc_protocol() before
  unregister_netdevice().  detach only invokes the optional ->detach()
  callback -- it never calls ->stop() -- and then kfree()s
  hdlc->state.  Neither cisco nor fr implements ->detach, so nothing
  stops the protocol timer before its container is freed.

  (Additionally, detach_hdlc_protocol() ends with hdlc_setup_dev(),
  which reassigns dev->flags and wipes IFF_UP, so the framework's
  close-on-unregister safety net -- which would have run ->stop via
  ndo_stop -- is skipped entirely on this path.  Verified empirically:
  ndo_stop is never called.)

This is the same defect class as CVE-2026-63803 ("hdlc_ppp: sync
per-proto timers before freeing hdlc state").  That fix added
ppp_timer_release() as ppp's ->detach; cisco and fr have the same hole:

 * hdlc_cisco: cisco_start() arms st->timer unconditionally and
   cisco_timer() re-arms itself.  The proto has no ->detach at all.

 * hdlc_fr: ->detach = fr_destroy() tears down the PVC list but never
   touches the LMI timer armed by fr_start() when LMI is enabled.

Both fixes mirror the ppp one (timer_shutdown_sync() in ->detach), and
both move timer_setup() to the attach path: hdlc state is kmalloc()d
(not kzalloc), so the timer must be initialized exactly once at attach
time -- otherwise ->detach() would run timer_shutdown_sync() on an
uninitialized timer_list for a device that was never brought up.
Same subtlety the ppp fix had to handle.

Control runs (KASAN kernel with the two patches applied, same
reproducer): completely clean in both scenarios -- (a) attach + up +
rmmod, (b) attach + rmmod without ever bringing the device up.

The bugs were found by static analysis and confirmed with the KASAN
reproducer described above.

KASAN splat (unpatched current master, cisco; fr is the same shape with
fr_timer):

    BUG: KASAN: slab-use-after-free in __run_timer_base.part.0+0x807/0x900
    Write of size 8 at addr ffff88800a599110 by task swapper/0/0
    Call Trace: <IRQ> run_timer_softirq ... __run_timer_base ... </IRQ>

    Allocated by task 69:
      __kmalloc_noprof
      attach_hdlc_protocol+0x77/0x140
      cisco_ioctl+0x184/0x4d0          <- SIOCWANDEV "sethdlc hdlc0 cisco"
      hdlc_ioctl / dev_ioctl / __x64_sys_ioctl

    Freed by task 74:
      kfree
      detach_hdlc_protocol+0x164/0x440
      unregister_hdlc_device+0x15/0x30
      __x64_sys_delete_module          <- rmmod of the (fake) card driver

  The orphaned timer fired ~9s after rmmod; a fatal exception in
  interrupt context follows immediately.

Reproducer (not for merge; ~200 lines, no WAN hardware needed): a fake
hdlc card driver wired to the contract API plus a tiny userspace
attachment helper.  Build hdlc_trig.c as an out-of-tree module against a
KASAN kernel, then:

    insmod hdlc_trig.ko
    ./poc_attach hdlc0 cisco
    ip link set hdlc0 up
    rmmod hdlc_trig                 # splat follows within ~one interval

Source of both files is attached inline at the end of this letter.

Regards,
Chengyu


Chengyu Liu (2):
  hdlc_cisco: shut down the keepalive timer on ->detach
  hdlc_fr: shut down the LMI timer in fr_destroy()

 drivers/net/wan/hdlc_cisco.c | 10 +++++++++-
 drivers/net/wan/hdlc_fr.c    |  5 ++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

---------------------------- reproducer: hdlc_trig.c ----------------------------
// SPDX-License-Identifier: GPL-2.0
/*
 * hdlc_trig.c -- fake HDLC WAN card driver; reproducer for the
 * remove-while-up teardown bugs in hdlc_cisco / hdlc_fr / hdlc_x25.
 *
 * The HDLC API contract says hardware drivers must call hdlc_open() from
 * ndo_open and hdlc_close() from ndo_stop.  This module does exactly that,
 * without any hardware.  Attach a protocol from userspace, bring the
 * interface up, then rmmod (or `echo 1 > trigger`) with the interface
 * still up:
 *
 *   detach_hdlc_protocol()  -> proto->detach is missing (cisco) or
 *                              incomplete (fr/x25); hdlc->state is
 *                              kfree()d; hdlc_setup_dev() wipes IFF_UP
 *   unregister_netdevice()  -> close-on-unregister sees !IFF_UP and
 *                              skips ndo_stop entirely
 *   -> the armed protocol timer (cisco keepalive / fr LMI / x25 LAPB T1)
 *      survives and fires into freed memory seconds later
 *
 * *** RUN ONLY INSIDE A THROWAWAY VM.  THIS CRASHES THE KERNEL. ***
 */
#include <linux/module.h>
#include <linux/netdevice.h>
#include <linux/hdlc.h>
#include <linux/debugfs.h>
#include <linux/uaccess.h>

static struct net_device *trig_dev;
static struct dentry *trig_dir;

static int trig_open(struct net_device *dev)
{
	/* contract: hardware open -> hdlc_open; carrier defaults to 1,
	 * so this calls proto->start (cisco_start arms the keepalive timer,
	 * fr_start arms the LMI timer when LMI is enabled).
	 */
	netif_start_queue(dev);
	hdlc_open(dev);
	return 0;
}

static int trig_close(struct net_device *dev)
{
	pr_info("hdlc_trig: close called, IFF_UP=%d proto=%px open=%d carrier=%d\n",
		!!(dev->flags & IFF_UP), dev_to_hdlc(dev)->proto,
		dev_to_hdlc(dev)->open, dev_to_hdlc(dev)->carrier);
	hdlc_close(dev);
	pr_info("hdlc_trig: hdlc_close returned (proto deref survived?!)\n");
	netif_stop_queue(dev);
	return 0;
}

static netdev_tx_t trig_xmit(struct sk_buff *skb, struct net_device *dev)
{
	dev_kfree_skb(skb);
	return NETDEV_TX_OK;
}

static int trig_attach(struct net_device *dev,
		       unsigned short encoding, unsigned short parity)
{
	/* pretend the serial hardware accepted encoding/parity */
	return 0;
}

static const struct net_device_ops trig_netdev_ops = {
	.ndo_open		= trig_open,
	.ndo_stop		= trig_close,
	.ndo_start_xmit		= trig_xmit,
	.ndo_siocwandev		= hdlc_ioctl,
};

static void trig_unregister(void)
{
	if (!trig_dev)
		return;
	pr_info("hdlc_trig: unregistering, dev flags=%x up=%d\n",
		trig_dev->flags, !!(trig_dev->flags & IFF_UP));
	/* === the trigger === */
	unregister_hdlc_device(trig_dev);
	pr_info("hdlc_trig: unregister_hdlc_device returned, flags now=%x up=%d proto=%px open=%d\n",
		trig_dev->flags, !!(trig_dev->flags & IFF_UP),
		dev_to_hdlc(trig_dev)->proto, dev_to_hdlc(trig_dev)->open);
	/* if the oops above did not kill us, finish the job */
	free_netdev(trig_dev);
	trig_dev = NULL;
}

static ssize_t trigger_write(struct file *f, const char __user *ubuf,
			     size_t len, loff_t *ppos)
{
	pr_info("hdlc_trig: manual trigger via debugfs\n");
	trig_unregister();
	return len;
}

static const struct file_operations trigger_fops = {
	.owner = THIS_MODULE,
	.write = trigger_write,
};

static int __init trig_init(void)
{
	struct net_device *dev;
	int err;

	dev = alloc_hdlcdev(NULL);
	if (!dev)
		return -ENOMEM;
	dev->netdev_ops = &trig_netdev_ops;
	dev_to_hdlc(dev)->attach = trig_attach;
	dev_to_hdlc(dev)->xmit = trig_xmit; /* contract: hw xmit (x25/LAPB uses this) */

	err = register_netdev(dev);
	if (err) {
		free_netdev(dev);
		return err;
	}
	trig_dev = dev;

	trig_dir = debugfs_create_dir("hdlc_trig", NULL);
	debugfs_create_file("trigger", 0200, trig_dir, NULL, &trigger_fops);

	pr_info("hdlc_trig: %s registered. Now: attach proto (poc_attach), "
		"ip link set up, then rmmod hdlc_trig or "
		"echo 1 > /sys/kernel/debug/hdlc_trig/trigger\n", dev->name);
	return 0;
}

static void __exit trig_exit(void)
{
	trig_unregister();
	debugfs_remove_recursive(trig_dir);
}

module_init(trig_init);
module_exit(trig_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Fake HDLC WAN card driver (teardown-bug trigger)");

---------------------------- reproducer: poc_attach.c ----------------------------
// SPDX-License-Identifier: GPL-2.0
/*
 * poc_attach.c -- attach cisco, fr or x25 protocol to an hdlc device
 * via SIOCWANDEV (must run as root, device must be DOWN at attach time;
 * the up-state switch is correctly blocked by -EBUSY, which is why the
 * trigger uses the removal path instead).
 *
 * usage: poc_attach <ifname> <cisco|fr|x25>
 */#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <linux/if.h>
#include <linux/sockios.h>
#include <linux/hdlc/ioctl.h>

int main(int argc, char **argv)
{
	struct ifreq ifr;
	struct if_settings ifs;
	cisco_proto cisco = { .interval = 10, .timeout = 5 };
	fr_proto fr = {
		.t391 = 10, .t392 = 15, .n391 = 6, .n392 = 3, .n393 = 4,
		.lmi = LMI_ANSI, .dce = 0,
	};
	x25_hdlc_proto x25 = {
		.dce = 0, .modulo = 8, .window = 7,
		.t1 = 10, .t2 = 1, .n2 = 5,
	};
	const char *ifname, *proto;
	int fd, ret;

	if (argc != 3) {
		fprintf(stderr, "usage: %s <ifname> <cisco|fr>\n", argv[0]);
		return 2;
	}
	ifname = argv[1];
	proto = argv[2];

	memset(&ifr, 0, sizeof(ifr));
	memset(&ifs, 0, sizeof(ifs));
	strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);

	if (!strcmp(proto, "cisco")) {
		ifs.type = IF_PROTO_CISCO;
		ifs.size = sizeof(cisco);
		ifs.ifs_ifsu.cisco = &cisco;
	} else if (!strcmp(proto, "fr")) {
		ifs.type = IF_PROTO_FR;
		ifs.size = sizeof(fr);
		ifs.ifs_ifsu.fr = &fr;
	} else if (!strcmp(proto, "x25")) {
		ifs.type = IF_PROTO_X25;
		ifs.size = sizeof(x25);
		ifs.ifs_ifsu.x25 = &x25;
	} else {
		fprintf(stderr, "unknown proto %s\n", proto);
		return 2;
	}
	ifr.ifr_settings = ifs;

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0) {
		perror("socket");
		return 1;
	}
	ret = ioctl(fd, SIOCWANDEV, &ifr);
	if (ret < 0) {
		perror("SIOCWANDEV");
		return 1;
	}
	printf("%s: protocol %s attached\n", ifname, proto);
	return 0;
}

-- 
2.25.1

