Received: from mail-ed2-f6.google.com (mail-ed2-f6.google.com [74.125.228.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF732351C13
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671654; cv=none; b=sP4LO1emSTLp7kl6TVIBDxfav3VNmd0p0ADvZAD96O+sYd67EpQlRnNoaEKlIIREarC6wq0zpONDEW6lItSMbgBPM3llcHAET2nE3wYIWdKaqfPwBvSNlRuuCciJOL3rEBceS66bcYIiePpfKRpHWvRsBOV8lnGI1n0DMFbqHw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671654; c=relaxed/simple;
	bh=uQVz+K1/tiwkasTG+w79z8H2afc5AsmIftpAEk5RMkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uR5Bhfx3fS5VeI8jbrIUUdKptzQK1KFRWL8A8m5ngSI88pX6ee0HeeuaQnacGRAC0IoCZHrdnqe6bM3R3/tc2d1F9oXOmPC3cSjMiFY6AxcIMOObqy3VlsKI6K5n2OlgtrhbV9HdFLw8iyvYegA5m4m05V9NBlO6ERkFqBpjVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed2-f6.google.com with SMTP id 4fb4d7f45d1cf-6a5d790cce1so255889a12.1
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787671651; x=1788276451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5k9HBpOvCsTp3v94rUbWHBbfWVbyD8PJy/u/PILaBw=;
        b=kO9WbnurpLoDTlDpQtMLdSbB8tndvYisA6yq9ai9eiF+iG1kznB9/8fGx6CVaAXePO
         a5Ts/nCUlUMoglg34EuYF/tvxs3ZswHa6gpk4d7Gj3t+VddkBJQSPLuGjNE3APdI1+Gt
         GEwHpWSb1pyDVnwbFzpvO8lwXxOBwXP6PY7p10I8m8J49902w+pO5WwBK8uskeqgDxjH
         ufdsXqaSdyd/s+T3cDHL5q5Ahj+33w+mTGNpkSOQX6auMyL3XLelh+YnHy7U4vkDsM7i
         o8aiXlF2PVoGLai9X95MH48I1/rSKhQQ82SEDbcFrLRAUWVq51QFTgO6scCqOfApdokE
         FzdQ==
X-Forwarded-Encrypted: i=1; AHgh+RpaN7JPbGay8rZNEmKewsjdc/D8JEoXrFZZXRPqsjcKYfAOoj7fpeLthu9qNOK24sf1YudR1Ts=@vger.kernel.org
X-Gm-Message-State: AFuF++m+wZnwNk3eko7yPyAhTZJucHPLe+/hxwoieu+LprEAimlfKktk
	5HLejfvif20OC9Y4GkDPZ4pnkIR4y+SYAvzzLZx/kQK2YSnrp3he/9yU
X-Gm-Gg: AR+sD10BT+vi6AGHFrgcKKdk8M+gqs8flryljWtBoLXMCd2c0FBEox9VxQ3mg0R4NBY
	iyrQD0eSmuDZ9ZGOtsRXo/WkZej7g+wtongrgfRcLEg6VcynGDvLV7UJEgK85cvYEZoiyUPn/+x
	IU4vOCl5EcXLH9ALCt+sxjcgTay9qycmzAfHaAKiC9zCzoMe0/NqEKl88M0qsb/qnffDFdESdya
	iTidGGmVMHJ5S0RgDqoWT0HN7Un1U7Xd1Uu5rJnVxma1/CzE03RuDyeCKWA8vKnPy/D5xWIzPg3
	IzaE/SvMRqpqWU1DJF3eRlAb/OLOWg0PGCoAfh+wjJAKEbb6MZGBz9R/NrwIrhC8Yp712eHDao6
	E3vbpOmIqqs+0o6Ew2Tzl32E7cfqHxO1ye39u6FuKA7nvQhmzHY4Igp/SYOytQUHTFp/JoffuE+
	eIR7+RZ8VZtG/TBCtZ3ByY0jGruD+KH9UK4Xb5vcPpE4hiuqZBYM3D8zRsvHaSHY9ChOGkAZVLi
	UG910Ay74i590rs9lSzOUEpeN8xdSc=
X-Received: by 2002:a17:906:f591:b0:c24:6045:2a94 with SMTP id a640c23a62f3a-c24e5c8ad60mr1019878166b.4.1787671650465;
        Tue, 25 Aug 2026 08:27:30 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-33-32.nat.epc.tmcz.cz. [89.24.33.32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9ef996sm1808866b.62.2026.08.25.08.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 08:27:29 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Romain Bellan <romain.bellan@wifirst.fr>,
	Florent Fourcot <florent.fourcot@wifirst.fr>,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH nf] net: netfilter: report NLM_F_DUMP_FILTERED when all is filtered out
Date: Tue, 25 Aug 2026 17:27:24 +0200
Message-ID: <20260825152725.3678225-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NLM_F_DUMP_FILTERED is only set on data elements in the conntrack dump.
But when everything is filtered out it is confusing for the user space,
since the flag is not reported anymore and it looks like the table was
empty, which may or may not be the case.

'answer_flags' were introduced precisely for this use case, and the
conntrack dump should set the flag in there in case the filtering was
applied.

This is important, for example, to be able to tell if the filters are
supported or not by the kernel without modifying the kernel state.

With the proper reporting of NLM_F_DUMP_FILTERED on NLMSG_DONE, an
application in user space can just try and dump with an arbitrary
filter without worrying that there could be no matching entry.  The
reported flag will signal that the filtering was applied and therefore
supported.

Fixes: cb8aa9a3affb ("netfilter: ctnetlink: add kernel side filtering for dump")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/netfilter/nf_conntrack_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 9b4e29557ec3..579ada063b1b 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1077,6 +1077,8 @@ static int ctnetlink_start(struct netlink_callback *cb)
 	}
 
 	cb->data = filter;
+	if (filter)
+		cb->answer_flags = NLM_F_DUMP_FILTERED;
 	return 0;
 }
 
-- 
2.55.0

