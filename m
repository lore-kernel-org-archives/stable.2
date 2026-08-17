Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6F3C65FD
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957440; cv=none; b=WJBOhK1Ux45NupFX/TdzocJUFEKpZdFSUpJxKJ0EVhYEFi+J9OxKbnfdUgPIuC0FBR3vd1TNj/WCW/8JH03clOQxSGojP9KoU6EfYifWdLiC40X5wMcBUwqbbio8EA/cH1U8JsrgACZlYpSLJcdwgDrRIhQdvHo9lnpMxqNjSRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957440; c=relaxed/simple;
	bh=jmcCgsbGNKvQsGopZdfhbfD93w4f5WcJJOrmkdyxHBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nrl/q/YEmgDa4Z1VATR+r6fQs6Hfpfir3yQZDgelu0mumUhDQbONIf/tt30nZt4gMiVG25EI0/MLkdRpqRGELRtUwJGdTyA92qsURSKoMIbTZUk7q81o2tKAU4JZn/bNQDxcJpzhr37+izmw224OVtAB6d1pBunHbAjPWd761jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ofGRpFb6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofGRpFb6"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848761b5897so992539b3a.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 02:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786957439; x=1787562239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g951Y30fAYIITqf5Upt52gggx1O3bnI71YidBFSIjvY=;
        b=ofGRpFb6GrgWajH1QI6mzY5/MnDc/WDM0j2JtyWu0RD63CSgYSfE5DwEGAXl2abj85
         d47ZbsEJz7M8FCBNC1QIP+oi8EP8ynOxt2ddyhLv2QGUJgqUPa5oGZwytkrabdNZB/qG
         Fwe5LoTPRilnTW0HVEaK1k8p1N8xSEezjCD8BbsPEhlGDn/HReFOWOsj8w1h8rUHsKML
         +PuSidRixyZCh5snW7Dj/ABjv8fKaZ64aWkbf79vVBDomlm7H6QPsor1nlVpkrbRK1y6
         X3KinlDYRZsl68+Ty5ocEB0Twr56vvVSs1mdudVSPy/fEibuApkNUd0TUtKMe3+d3lzE
         9KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786957439; x=1787562239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g951Y30fAYIITqf5Upt52gggx1O3bnI71YidBFSIjvY=;
        b=IGL79tekT9+/G6LfOYPomdFSbCHipA3lWxRKynSeQ9WkhaeKmxS+kV5R0CHLSSUvwF
         eoKR+akBD229A1w0ISamCgjZpazVrBd4+ZusxzuVSM1PoM5WsFwx/KRotxeQNXtU33ON
         YXJ+qX8cK4vIxWblnMnfjXZMnXO9LgECqd2QV2XkLmRuEDATycnyaQhRi/1l9O2QqWuU
         /Q5lTzOIxjbSWGY9WXATVMk9IbyZOS/rUEwiNAZ5/g9SQAvxu+ZEXfDwsQwVLDKNKmcW
         Q1K3nY5ElYtIWPUKLZ9xkFElNzBOQOwrtkq9I30pev+mcjhJ161k28N9pxCj4jZeGCBH
         32Ug==
X-Forwarded-Encrypted: i=1; AHgh+RruvOVKKrcTN99I+c6oDtsONOik6jmJjHgcFXzM2/yo33NDpYjeGF6JB15HFiSY7mnibEnjUO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHgTduqxTypAtkG9quewUY1dVhRhUemK8mVNZtHLPj6xUA9YGE
	CzJNS9gzcQ3p7vGmtLShOm54M2WUwno+DDlfNU1vsW56twnvUZp7fy8+
X-Gm-Gg: AR+sD10plsRk36xRiOf/zFgI+y7zHVHpEJAEVQ/zc+ydCW12NjmGZppFsp34qkAOSzm
	wQm6DxvDLJ9mCS31DwhLZFJnXzh/bjecxep1pI9HRdmoN01cyE7CAuwdk6ILnd/BcNRZu9EzHZa
	bLcO5fIJ84LqLBSsJUNdAb/8ThTY2ibaZcYYS+qCURVhq5NgROFb5Xc4rpV7FarU7nUXE+Sj3i+
	IwR2ve42DRzM+Pjo1QK49AftdC/zarbUkiQXYTCJ/MYOrm7YELdHvCCcqq4fgpR5izxcdPI9MIM
	Yio22h09WKEFHgrGmOmjHsFywOcfKSQ1IVQT5hGyrd7pyxCGTd9q7+mwYbQbeaZ1S3R0zIlZArf
	G460mXLTvv7OVpXn/inGBREAKuU2f2iyMOkTAOnNZzZFkQwVJ38m0uH5i1MvsaYXiROqX5RKQ0v
	4OYfypUBUWYqWIfi5z/oX3k2BdXh4Uc6/VovurCs7i0yIHwO88LSNaVTDCoAqP5aqI9wOv2fu0F
	yLVrCsFTcY=
X-Received: by 2002:a05:6a00:1895:b0:845:4928:8655 with SMTP id d2e1a72fcca58-84fde33319bmr22306634b3a.39.1786957438516;
        Mon, 17 Aug 2026 02:03:58 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d2476easm2342517b3a.42.2026.08.17.02.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:03:58 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	horms@kernel.org,
	willemb@google.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	imv4bel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net 2/3] net: fix out-of-bounds write in sk_clone() racing with IPV6_ADDRFORM
Date: Mon, 17 Aug 2026 18:03:16 +0900
Message-ID: <20260817090319.3897799-3-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817090319.3897799-1-imv4bel@gmail.com>
References: <20260817090319.3897799-1-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk_clone() allocates the child from sk->sk_prot, and IPV6_ADDRFORM can
change sk_prot under it. The conversion requires the socket to be
established, and a listener gets there with connect(AF_UNSPEC) followed
by connect().

tcp_check_req() completes a request without the listener lock, so it can
run while the conversion is in progress. IPV6_ADDRFORM stores sk_prot
before icsk_af_ops, so tcp_check_req() can still call
tcp_v6_syn_recv_sock() once sk_prot is tcp_prot. The child then comes
from tcp_prot's slab while the AF_INET6 code treats it as a tcp6_sock.

tcp_inet6_sk() is a fixed offset into tcp6_sock, and in a child sized by
tcp_prot that offset is the end of the object. The ipv6_pinfo copy is
therefore a slab out-of-bounds write of sizeof(struct ipv6_pinfo) bytes
past the child.

The out-of-bounds address is also stored in the child's pinet6, so
everything that reaches the socket through inet6_sk() keeps writing
there. A request that arrived over IPv4 takes the same copy in
tcp_v6_mapped_child_init().

Checking sk_prot before the clone does not help. It can change between
that check and the read inside sk_clone(). Use sk_prot_creator instead.
It is set once in sk_alloc() and never changes, and the socket is
already freed back through it. No caller that replaces sk_prot installs
a proto with a larger obj_size than the creator, so the child gets the
size the parent object actually has.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 1ad41904db25b4..098e58b40f304b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2479,7 +2479,7 @@ static void sk_init_common(struct sock *sk)
 struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 		      bool lock)
 {
-	struct proto *prot = READ_ONCE(sk->sk_prot);
+	struct proto *prot = sk->sk_prot_creator;
 	struct sk_filter *filter;
 	bool is_charged = true;
 	struct sock *newsk;
-- 
2.43.0

