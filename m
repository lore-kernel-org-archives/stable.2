Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83123395F;
	Thu, 25 Jun 2026 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411723; cv=none; b=H4Ig6SEoLy53rx2OUDVTbk429kwPC8Ixr/dA4I9vDTy3Qm/unCI8p9C4Pum9zZng7cXbRl5rmf7vyfbxthJcB4Q0k8uRxV2oZvvy8CZE9UaWbqb3+jIpbyduhAm1qaR/4j6mU4mQDxMqQu2K6dkmwOZ7ZX2tjKalVTPe0tcu+4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411723; c=relaxed/simple;
	bh=XQ53pe/Jq8Z+Ffdi2ZgG+P8nlFouXKNplbiEL69TedA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YCXQb//IEi8LpmW1CTQIR7l/Wj4xGOy9yofqU9F0u2FwNNWrHmW/wPbEz+HmYlDT8SZZxXHNn7PuQAlaGrfH6bMTCTFcFpQ300VeyRsK42Olm12AZvBngDhbMsT5CUCLEVZ+PfPvOTpJlAcl9KBVKWGUb9JnTiCdFzBCn106ync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbNcI+hD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbNcI+hD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F9A2C2BCB3;
	Thu, 25 Jun 2026 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782411723;
	bh=XQ53pe/Jq8Z+Ffdi2ZgG+P8nlFouXKNplbiEL69TedA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nbNcI+hD4YojfcmBlTQ8EkFwujbVSf7ym/7ciFmh63AIWyeCsKElzLxFT7bYDb8A8
	 64T7quoyA9KN8UuLkYqRoIN7W136C29w/12j+e6uLILe2xcFI4JGzWtcj5eUUUAefn
	 UcXdcNEshGCtU4vej9fbzGKED2l0zmtni2YXEbzqZTnBiBYI+9MV0V3Lb1YhBzVTZF
	 jaFzp2L0SSDkTXa3d/0qqyie9ATmB0WABaNkIysWs6wmb36XMpB59HleCVjey7Xywh
	 Dqngly8XZc3mYj+Sg8+N1rX1EwIjOZV367gamPQKEX76dT8ECinzkhu7tjQgRDiqyj
	 zwSNo7ZooWDaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4CACDE00B;
	Thu, 25 Jun 2026 18:22:03 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Subject: [PATCH net v3 0/3] tcp: TCP-AO connect() fixes
Date: Thu, 25 Jun 2026 19:21:38 +0100
Message-Id: <20260625-tcp-md5-connect-v3-0-1fd313d6c1e0@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJxPWoC/yWMQQ6CMBBFr0Jm7UQsUKNXMS7a6SBjwkDaakwId
 7fV5Xt5/2+QOAonuDYbRH5LkkULdIcGaHL6YJRQGExrbGvNgJlWnMOAtKgyZQxkOnsJ57E/9VB
 Wa+RRPr/HGyhnuP9levln6etXzbxLjD46pamqEh5nJwr7/gWAJJKUkwAAAA==
X-Change-ID: 20260625-tcp-md5-connect-dc2369d7f414
To: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Salam Noureddine <noureddine@arista.com>
Cc: Michael Bommarito <michael.bommarito@gmail.com>, 
 Qihang <q.h.hack.winter@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, 
 stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782411722; l=762;
 i=0x7f454c46@gmail.com; s=20260625; h=from:subject:message-id;
 bh=XQ53pe/Jq8Z+Ffdi2ZgG+P8nlFouXKNplbiEL69TedA=;
 b=Y7z8nzcRMUDzxvqM7RljOh8KweK3DMHV8ICMaFA05PjJgEO3zSkUJxtrhQHXWTzSkEoIp7UgX
 d88tq5AcaTEDzlQwBvZq1J6tg9JGtkqXSqsrxf0ShwkFRsiYIrfbX8b
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=clHVGbfKfZMeCUp+xCL/096jI68XK5EZLytgy6lSyrc=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20260625 with
 auth_id=841
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

Resending v3.

I've addeded credits to Qihang on patch 2; and a third patch/fix
for static key decrement.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
Dmitry Safonov (1):
      tcp: Decrement tcp_md5_needed static branch

Michael Bommarito (2):
      tcp: restore RCU grace period in tcp_ao_destroy_sock
      tcp: defer md5sig_info kfree past RCU grace period in tcp_connect

 include/net/tcp_ao.h  | 1 +
 net/ipv4/tcp_ao.c     | 5 +++--
 net/ipv4/tcp_ipv4.c   | 4 ++--
 net/ipv4/tcp_output.c | 8 ++++++--
 4 files changed, 12 insertions(+), 6 deletions(-)
---
base-commit: 02f144fbb4c86c360495d33debe307cb46a57f95
change-id: 20260625-tcp-md5-connect-dc2369d7f414

Best regards,
--  
Dmitry Safonov <0x7f454c46@gmail.com>


