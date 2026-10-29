Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291730;
	b=4vf+/h9a3BGXA+Y/ZbjFxvImJWKkvEtWoypbUH6Ao0dLLVoYv12kojCMVM7NboaOa4BI
	 Jd6widonETAMrSfjQCm3p/SjolFy1cMwppDsjafAX3+SXO0dcleFf7a1xFWVWydEJrFV1
	 cRF5y+K/ezBsXryIDta/GGdEbuJa13vuZOzpF9Q+iJ7cUkSI220XsGdhP9igFHsmV1wwz
	 6EmjQxpvI6OxjDhDSl4xTCvtcB1Y5oPOURG71WN5VtTFh2NTHRV9zJkRIsYbkX8ePu91a
	 wv87UGPNX4t6hGyd3U4cCQ1/4Io4AZDY5CYMfZHUMCTxxX52Wg271ngf9iycUK5RsVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LjpmfPa02oFewXlsIf8j68q6+knr6ZZYk1Rx2rngfoc=;
	b=s0LEnpAusqBHyLx5JhMWhC60Icp03fGTBtFHLauZe3ysI7nnzg6Y3ZBoSOTgYR9CdP1O
	 bkLV/uSFeTgTamHewzGdl8xDJAQTuU8KWAWMI5bdL5R5iGo8RR+hZgSq+BqDs3BdSgr6K
	 gAta/xHY1bYpRux/yRc6jRy09/sEaA7qEhKqLuqHsUSW1btYchhawT37R7Y0tw4L1/zAr
	 PKySgaca/+TrKKmRmEPOxW0x1SDTNxADl/EjJvbl34/mzxmYEWWorPPqYk3yOF5b35ZRQ
	 9S3MxsYFT92sXtUZqoUk/63lyUTi9fnYgp+FCm1SyhzMKoLy3P+WnbkErLNVEBzQ4zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a+HrVonC;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B4606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 917B4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a+HrVonC
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3550c917fd3so3311962eec.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793291729; x=1793896529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LjpmfPa02oFewXlsIf8j68q6+knr6ZZYk1Rx2rngfoc=;
        b=a+HrVonC+ueltPtJX/RKfwzScxcTZsAOlTxYT6UHflrSCP1NyNoO608Z9cAAmJ4MKJ
         3iJQc7XG7LEWHVTphTHdhRKs86nCQP9iu4f4JEYSC1rNVaPvnt3TcdVWLK0qrwZpQkY+
         i/kR5dw2uW9UIq9DBKZyypbpUo3BBj726Lueo011Jn8dxajGWG3YsJeV0od1tVekZLdS
         qTB1w08YCDsugrAAOxwi2kMPpxHWGzrJZxeQ6D11aVGh7vLNOBrgGPfbtbehX9bDSuTN
         U0aTLeC289yZgfShVodZcXDybakZasyKqGeMjvDlwPMKj5YV6KFKgAhRqDyMqZL3wq+d
         SHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291729; x=1793896529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LjpmfPa02oFewXlsIf8j68q6+knr6ZZYk1Rx2rngfoc=;
        b=DZqaJhr7+6C4OTiddGXv2xp7bwibvLl5yjiLJ8i4AtN1C180mcYD8GLfD7SiFpxLjp
         Rn/lg8juWuF4Xp9F5WtOrCg+XJ3JkWRNmV4B3rih/jtzzMCYGvldSRqQZ4CWR29GG2AD
         LbtZ2zoaE9cNjcGOL5ah0zqBY98pFa/4Eyg0irmY3oj/QG1oY/VeFUXBW8HGcPmQQXoY
         HJOfY57tcIEar2MdYlmqsbfa97b+hIGoYnCcE80kUIFSTiVJ5EAIJMgwvSTYQIegEBrv
         hf1sg8AXEhPijUMK/L432XRK/DagIljG6cRQIAMGGWYvgSVOqS+klXG/8T3k1URHvgwc
         z36A==
X-Forwarded-Encrypted: i=1; AKwUvBwhpnfupzSN3/IrlGwPnuvj1YsTa/ZlxZEWJt/WUCzsILZvSwdENHi49ll+/FpYmZnYz2EZwjc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQwpR8KN4cr6OTMsERzIZeGy0rXDAo4PjgkiDJhOjwxAKXqubM
	aFz6pwQs0p0wH4jkLJANW2QLck+DzXGrlLb/WR7w4QpIl48Vu3joSUXa
X-Gm-Gg: AYBFou1SZl03w6jp4gjF13zKm85+/F33bIlKSydsGqa1kFclR8F8WwC0hOCU0DFjrxd
	5PS00WgjisGdLrUSlGyTUGWZOmyt4MX9hp+Lnbdd+SXK8yMcZg2KW9pEVBBXuiEJ/2j0GNo3sHE
	NoRV5J2fKjTmT0Q25GLluNwlLCb1z5RE6s78wDExmuSahl/ZsoTDu4IwaVxoX6vSOib4tpVfT7I
	MRtOR+D+W815INGS4ofIxBzdBo3ej+0ZUgcnZSGhizugExEBo4Y0NWE2IR/OmKKiEkY3/DLrxak
	1GxYRgMDzhDRogWc53i4OU6wY0SGjuxKTHmRyCVHBrQofnHhOMNHJ55FJSskcoLvOI9hb1+2nqw
	H82SpYkhfTPaTsOSwBI24/Y/WyNfVnh809pc8kTiza6DDMEtNeaVE4als1FNOWp/EN/xY1DyVcd
	uvYFVnrJKnLI42etmarGRCEr6d2oK7zpgyHTVQbaO+p/Axs4Yk7SG7zmLmmT7NL6EacTo3pKef/
	aRyq3xmbCYEEbcaGdlpI+FHQXukqRekezb9u5bg3DXMzo6BbbVZM6XdNyAQzjuQtVsiYRKobEGc
	JZn2D6xbe7ozyneZrduNgD3plP9nM4tlEegu0znnISjSlJkg
X-Received: by 2002:a05:693c:2510:b0:34b:4b99:24ab with SMTP id 5a478bee46e88-36a203d426amr7788717eec.22.1793291728260;
        Thu, 29 Oct 2026 09:35:28 -0700 (PDT)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a40fff7d9sm302071eec.6.2026.10.29.09.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:35:27 -0700 (PDT)
From: hyunjungg <hj351016@gmail.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: em_ipt: reject hook values >= NF_INET_NUMHOOKS
Date: Fri, 30 Oct 2026 01:35:16 +0900
Message-ID: <20261029163516.2476127-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

em_ipt_change() reads the TCA_EM_IPT_HOOK netlink attribute into im->hook
as an unbounded u32, and check_match() later uses it as a shift amount:

	im->hook = nla_get_u32(tb[TCA_EM_IPT_HOOK]);
	...
	mtpar.hook_mask = 1 << im->hook;

TCA_EM_IPT_HOOK has no nla_policy range (it is a bare NLA_U32), and the
only range check on the hook lives in policy_validate_match_data(), which
rejects hook != NF_INET_PRE_ROUTING. That validator runs only for the
"policy" match; the "addrtype" match added by commit 0c4231c784b4 ("net:
sched: em_ipt: add support for addrtype matching") has its own validator
which does not look at the hook at all. A filter using match_name
"addrtype" can therefore carry an arbitrary hook value.

For hook >= 32 the "1 << im->hook" in check_match() is a shift that is
out of range for the 32-bit int, i.e. undefined behaviour; im->hook is
also passed unchecked to nf_hook_state_init() on the match path. Valid
hooks are only NF_INET_PRE_ROUTING..NF_INET_POST_ROUTING, so reject
anything >= NF_INET_NUMHOOKS when the attribute is parsed.

Reproduced on v7.3-rc3 (CONFIG_UBSAN=y) by adding a "basic" classifier
carrying an em_ipt "addrtype" ematch (match revision 1, nfproto AF_INET)
with TCA_EM_IPT_HOOK = 32:

  UBSAN: shift-out-of-bounds in net/sched/em_ipt.c:52:17
  shift exponent 32 is too large for 32-bit type 'int'

It requires CAP_NET_ADMIN (a tc filter add in a netns the caller controls).

Fixes: 0c4231c784b4 ("net: sched: em_ipt: add support for addrtype matching")
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 net/sched/em_ipt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sched/em_ipt.c b/net/sched/em_ipt.c
index 3650117da47f..c16469fb3e92 100644
--- a/net/sched/em_ipt.c
+++ b/net/sched/em_ipt.c
@@ -165,6 +165,11 @@ static int em_ipt_change(struct net *net, void *data, int data_len,
 
 	im->match = match;
 	im->hook = nla_get_u32(tb[TCA_EM_IPT_HOOK]);
+	if (im->hook >= NF_INET_NUMHOOKS) {
+		ret = -EINVAL;
+		goto err;
+	}
+
 	im->nfproto = nfproto;
 	nla_memcpy(im->match_data, tb[TCA_EM_IPT_MATCH_DATA], mdata_len);
 
-- 
2.43.0

