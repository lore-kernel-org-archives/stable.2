Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFC37F735
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791243533; cv=none; b=RKkFdyVbvZyhPhr9vWwaQAh8/KJW4Ak+9G+TVUthVeOqp2GYUFbghKyY82+2QywVtuabXByIob7iE3NLggg9FG0ak0YV0xXvE1uH5xZ8hKIYIflvGyxjTVtZEzjeRd9E6xqEuHOw3Ahin6NdYbHWgC3k5Qrffb7kr6w3xmGLSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791243533; c=relaxed/simple;
	bh=k4VxHYPDQlNlaPiDWtm0njKpKpXdpMpaZHAGx8QED6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mbp4aOVadzEDUNomEIC2NpOOKu/lUtbNkagYm19BLbctMKQ2WwHRsNC+zKvJ+hMq1VyQHf+TEcXVQBkaecoWx+8XeQ6UEeN52jzFSPvFD+rUZwR6c1X3eA/k9NjYkndsyRjwKoULOO0/NHVG0ArChD07UytK2gG2HxxsXbZzRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYmzus+A; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYmzus+A"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3ce4795aso2135905e87.3
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791243530; x=1791848330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+DTqPd+FK0C59toCv/w+p9Wc2puRzcD2Gcg0RCLDBBo=;
        b=KYmzus+ApmwDnFLZFFqnp1g/+A9txQ88302wmvDdKsfjiOB3tpp+l+MFyEHstayQDn
         LlB757OOZ3tzDimPGVk/QsGLUCOCivXc8UgS008tG4236d+s0dKCXDLgfPE0y0361HRY
         wfAZbD/m/MCs7dE194WNyAvSzy5TLuPS+8dGY0BRMzlt9XHGo2c/SUkN06H2vx0Rfuki
         iOE50YyhXrDHFaLH8kfCmHkhzY0KSJzOwRpdn7j91Ac/di1iIBdJcu4XBgRgIeF7LZ+x
         tYgUiOrfFPlDZiENFwDZkPDIC6KIHM8z5n+OInvp9feUd6Ud4tzCKw2gjyrASqWTsQaE
         ANrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791243530; x=1791848330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+DTqPd+FK0C59toCv/w+p9Wc2puRzcD2Gcg0RCLDBBo=;
        b=Lo/IQH8Zj0fDVEHv9UcpS0jSEknLZ6RbMERtI5VC6nG2HJ1vhfRfr++jUjs+yhGXLQ
         OEm3gVKKssFd3RqQoUaptcZ8EKTCBxG0rYf3TAyht6WA2spPptJ1tfkPQWqpGghde5h2
         zmnPC98iReSYaGmWaSfcrlLdBAbXLZUHcPRlZUfr9OdyU4uM0L6PNSeIzlbEiLSVxG0O
         WpkesTIH6MxCqPUFrZmjyLbapzSry97PrRI8jauCAQFI8ZxM20O9uopos83GXOYBOnia
         CmmlVDf56DSi2WoHIe1Yjm328klc3Rde2hUwWXftuy+FKCAhvNHaoOQZnC3vQlKh6NYG
         PBLg==
X-Forwarded-Encrypted: i=1; AKwUvBw3F6NY7QA2O4+EV83mmnNt3ZR6N9nyKMmX/iT+bFLjkE340Yv9cG7Ft+r6BJOd5icO6eSp88k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1Ern4eyJdQFEvoVA5JGYLcdh4e6W+Fb+p6om/jdojtU1LUHnw
	u1LQ6mxnGSmDY3+aLny++8+TRimWJ5OYe/qPWws310+qhg4BK5TvuXfn
X-Gm-Gg: AYBFou1pb5w4I2zqea9xJylHJnzsG9LUx++Zc/BuNYg8I2tfqhwp4bpaCZKwScshHPN
	vMFmnCacRZrABQH+RVhox9mAjqtqQl85k96nZi4H9xM2g2m60cauuLX31pxG+0wneCO9JYI14ys
	4k1ce2W/l7bEpJ4Q2AgyI6wpVKLyO0RC2+gm7K3ENOhjKRRg3UfS9d2b5biarKUXw+dyY0lrFRB
	4Uv9zpBLDAX/NVzQqtoF7AO8TS5jB6U77VdlqrZmkkbFf7QJ2nn5tkCHBXwud8uR6CI1w73J+rq
	bVIRW2mmHJpwueP4k7A33IftG/08Uul7UvxD4uLEQtzEggjRtCe3/7Iyqt98Rm/BsgcM9xa6Ups
	nYv0yiAjMWDq0t2A8t8ytyzPYEG2g3RZoOrNpUzt+GXJ+6j9Nco4TIxNX0Wsw8Znss0ZWaNQjx3
	2BQg3E4RVeXZ6vBQvIk/utL6OTLpBGg3f6o+EnI0i9vMNzjdhPXCunn61ykeOCWslVFlnCfK6Hn
	+zjcNaEliMlf6ZGOo3Iq5zorSXEXLZZX6UowoSxow==
X-Received: by 2002:a05:6512:3d21:b0:5ba:4264:da4a with SMTP id 2adb3069b0e04-5bb9bc5b39emr4566381e87.63.1791243529358;
        Mon, 05 Oct 2026 16:38:49 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.161.1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c7195b3sm3627196e87.8.2026.10.05.16.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 16:38:48 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	William Tu <u9012063@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] ip6_gre: let collect_md ip6gretap send from the unspecified address
Date: Tue,  6 Oct 2026 02:38:41 +0300
Message-ID: <20261005233843.936597-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179122803467.1402591.12893544301783319251@kernel.org>
References: <20261005191227.894665-1-littlesmilingcloud@gmail.com> <179122803467.1402591.12893544301783319251@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 05, 2026 at 07:20:34PM +0000, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Hit during development of the net-next series that annotates these
drivers with drop reasons. An LLM-assisted review of that series
flagged the misleading "dead loop" reason this check gives to frames
sent from :: when raddr is ::. Following that up with code inspection
and testing showed that for L2 collect_md devices the drop itself is
wrong, not just the label. The review of that series on the list asked
about the same case, and this fix was promised in the reply:

  https://lore.kernel.org/netdev/20261005174649.853236-1-littlesmilingcloud@gmail.com/

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Triggered deliberately in a test VM; this is not a production report.
There is no stack trace or log message: the frames are dropped
silently, and the loss only shows up in counters. With frames bridged
from a veth into a collect_md ip6gretap device by tc (flower +
tunnel_key set + mirred) over a dummy underlay, five DAD-style
Neighbor Solicitations sent from :: give tx_errors +5 and tx_dropped
+5 on the tunnel device, zero packets on the underlay, and five
kfree_skb events in ip6gre_tunnel_xmit() (reason NOT_SPECIFIED). The
same frames sent from a link-local address are transmitted. With the
patch applied the frames from :: are transmitted as well, while the
check still fires for native ip6gretap with a configured remote and
for L3 collect_md ip6gre; each half of the new condition was verified
by removing it in turn and watching the case it protects start passing
frames it must not.

---

Anton Danilov
