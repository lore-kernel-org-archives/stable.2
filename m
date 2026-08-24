Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7610407CEA;
	Mon, 24 Aug 2026 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568317; cv=none; b=RsnFvUVrHFB+HamD9JuUGnRuidqjy3V6V3noPXCozmpKDbx4Q8QLQxhXp/sONiSxWAZlNM+PbHJLMztMt8ZUKBlx01/tOwh8+bW8YyWlsljYV4SobALxaaD/V8//pvhGCkmkM0pUH5C7E85usHHuDNcdb+s1akWeyfFNltI1Pvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568317; c=relaxed/simple;
	bh=ekimUOFKRsJW59biBg+6TH9kSS66XL+A2y6QCkT+DK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gTv1gJHS3eW0wpGSmxLd1xpmiHZ2gGUBXeciD6HwYC88D+0bSND27D/ESE9IBRM+rCS7PksM/QrRUaT7UNXUt/zCkvch56cJ7t/aieeyVrLRXePqJ+nhGGYL6TPV+nMnWPGvwNqkFBD+6hXIxzWxKRFdfehdsVq0Sn1UCxaFRAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=tf0zeAzf; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="tf0zeAzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1787567968;
	bh=ekimUOFKRsJW59biBg+6TH9kSS66XL+A2y6QCkT+DK0=;
	h=From:To:Cc:Subject:Date:From;
	b=tf0zeAzf+nKhB8vDjms85ZJiACDTbWR3Xlj/2qIhbmZx1CYHYlHESzpB0Vm9TOyOM
	 wY0WwQJ+bs3qO8d6Sdh2ht7Oq5z6bSyIc2FxBVKyRzdM1XKWEsIqzwWmABXJ/dxbuJ
	 qT/s7Sg6kww6W1Df5MgX3qLb9luJX+R3iyl4qNqo1RYkiHaLXd9PhnN3AftjSZP7qM
	 2MPU68OmPIii36NOJ6yJ8KXLFsG3PTpRFwtxSS+ukdj6x7ZXtvZ/RBERz/lGMUBbR0
	 TcNv33qeDDRmxU7OMzEiMeKav/w8Gudp+7i/q1i4KEHUwLdz8MvImfxBsYKVxoQ5du
	 meBIXkHXIrz1g==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 29B166000C;
	Mon, 24 Aug 2026 10:39:18 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 87320200662; Mon, 24 Aug 2026 10:38:16 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Felix Maurer <fmaurer@redhat.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] netlink: specs: rt-link: fix ipv6 devconf doc
Date: Mon, 24 Aug 2026 10:38:15 +0000
Message-ID: <20260824103816.40040-1-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

devconf is even odder than described in the blamed commit, where bpth
IPv4 and IPv6 are described in an identical way:
"u32 indexed by ipv?-devconf - 1 on output, on input it's a nest".

There are two issues with that line for IPv6:

1) The subtraction is an IPv4 specific quirk, to avoid having an unused
   u32 at index 0, thus saving 4 bytes per net device being dumped:

   - In include/uapi/linux/ip.h the IPV4_DEVCONF_* enum begins with
     IPV4_DEVCONF_FORWARDING = 1, so the enum starts at 1, which is
     the reason for the subtraction in the IPv4 variant.

   - In include/uapi/linux/ipv6.h the DEVCONF_* enum begins with
     DEVCONF_FORWARDING = 0, so subtraction would underflow.

   - ipv6_store_devconf() in net/ipv6/addrconf.c also doesn't do the
     subtraction in the output path.

2) Setting IPv6 devconf through Netlink is not yet supported, as
   IFLA_INET6_CONF is not handled in inet6_set_link_af().

Fixes: 720447bd0b24 ("netlink: specs: rt-link: remove implicit structs from devconf")
Cc: stable@vger.kernel.org
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---

Fernando, please remember to reintroduce the ", on input it's a nest"
in your WIP/planned patchset that introduces support for setting IPv6
devconf via IFLA_INET6_CONF.
https://lore.kernel.org/bd560c89-c71f-4ef5-a0fd-5ea096a0f767@suse.de/

 Documentation/netlink/specs/rt-link.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index b80c2ac3ac31..00c915031efd 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -2218,7 +2218,7 @@ attribute-sets:
         name: conf
         type: binary
         sub-type: u32
-        doc: u32 indexed by ipv6-devconf - 1 on output, on input it's a nest
+        doc: u32 indexed by ipv6-devconf on output, input is not yet implemented
       -
         name: stats
         type: binary

base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
-- 
2.55.0

