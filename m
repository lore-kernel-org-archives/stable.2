Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748352;
	b=CnG/Hicro9+yOoRlX3gVQEI8sSJDrcf8AcvkKKm9eiY3Hwx7wC2Yxj8XXCPpeg8zsyHk
	 YqScslSCJaOhshUF6oVp4Q/X7U6pA6SqUXqIZSfsamO85PEakVm3lxYPBiLCVhEq7l/B1
	 nEFO7wkroPKAgDWGSIYmarAuHIRXL+qbjGRF1flc87QQ9SvjqD3GoUG3XDDqrwZhuLfGB
	 3j28PjgeHuhk+XIDhA5WYCcAswjK0GQ2bK7NrGwS8kSHgRKnjv2O+d/jqjFbg1L6v7w6d
	 NK+EmPl1AD30t/f51iAbXOAaOEuBLu07XMEbfow9LvuIWbEoXEB13UoumsGLjjKnNEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748352;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 X-Mailer:Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=Gbwbh+7fh/5IsalAqYpM9X5Anu43yQLS58BbZrVnUQc=;
	b=CnayfjwNGe170tYjyMfcy48o6qQk4irQGZ0HHOcK02cUKQrEAM6KHHvNbd8mgRndzUVC
	 otkpA/9NiXb9ucFsfPsqQpSJw6FAu+qXeHR2LOGC4MqGciWEMSzhNCShLa8GGl23Bjt/5
	 L5hJK0btMpfPrScapit1/YwWxf+E7lC9fM0dwhaOgfRHy2GooYTX6+SAGHTS4yxSF6I0Z
	 KQmY02sQvTFh0CBBjlgoaxen80ulRNrA/gGxgtjzLRbtszSmB86NCj8laKn0657AKEF5o
	 8V0qGKRjjSPhV4u3gBVxm4k1GoFpP2oHflQ7QKdrWUFD4dMsd7ROqGrG+tnf8mM1GyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=glR6GbqE;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF81606A31B;
	Tue,  3 Nov 2026 23:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEF81606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=glR6GbqE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=glR6GbqEl6NIXWEKuBXQROmXtXYSErCAfO3/1LghctZfJdvd+zGgqj1SUMRyrHkQa0VxOOpMdvBMa
	 suqzrU06NrfkoENx9u0Wt6ToV3ph9+6uHQcV8Juk3TsPnzH/KMcFz2jX6rpqWZCukYXWGTsD93ajjT
	 zcg7lLt0bkUD6Lvs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36aea6d7a57d-628bf;
	Wed, 04 Nov 2026 07:25:46 +0800 (CST)
X-RM-TRANSID:2ee36aea6d7a57d-628bf
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.23.104.16])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16aea6d773cf-09782;
	Wed, 04 Nov 2026 07:25:46 +0800 (CST)
X-RM-TRANSID:2ee16aea6d773cf-09782
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com,
	jiayuan.chen@linux.dev
Subject: Re: [PATCH net v2] tcp: fix device binding after failed IPv6 connect
Date: Wed,  4 Nov 2026 07:25:32 +0800
Message-ID: <20261103232510.257708-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179371663219.488856.3400501885593862638@kernel.org>
References: <20261102143352.135769-1-yanxia@cmss.chinamobile.com>
 <179371663219.488856.3400501885593862638@kernel.org>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi,

Thanks for the review. I agree that the deferred Fast Open send failure
is not covered. In that case, tcp_v6_connect() returns 0 and connect()
has already returned before tcp_sendmsg_fastopen() encounters the error.

v2 restores the binding on synchronous errors returned by
tcp_v6_connect(), as stated in the commit message. The later send failure
is a pre-existing issue. Covering it would mean keeping the original
binding beyond tcp_v6_connect() and handling any subsequent binding
changes. I'd prefer to handle that separately from this fix.

The datagram binding rollback has now been merged into net/main:
https://git.kernel.org/netdev/net/c/bc53aab4881adc134f495092034e9e7c0791d84c

Agreed on WRITE_ONCE() for the scope assignment. I'll include that if
another revision is needed.

Thanks,
Xia Yan


