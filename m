Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1642A154
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184472; cv=none; b=RMvQfkGVooVOvOGLRT/8HDAFwEuYVMuyKdMCNx3WB0BhzuieE77s4c3cc+cLBbfTluC4lvtCClZDQrqRRmIWJKeMpGtSWt9lbZSQF/GmyDZE+/V5iBTsafFoVoHUthQOUvQsMqhzlqo68DUOeM/1g/eZZwjLGcfh8aXmV2EEhp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184472; c=relaxed/simple;
	bh=rnQu/Dyoz7rMgjAg6JRDK1ICaVCqQAJwtGvirC/XXk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eakv7pia0o+eAVqrFqINjWh8XPjQXXN2fTOMaIPXYnsBVWA8AYItRVJ4iYnYEoxxwd91HIpKDnYE+8E3v/RVL94w2aW2/tEqc5BSalzka0bnjmL05iLTiHWwBmY1UIrXI9Hbg/PiCGGd9OkVugPaYdS8yZOjqjLHn93WsVR6aKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVxkX0cK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVxkX0cK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785184470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gJbD0UYBY/q13F76z/tQmLjC5a55COLjlKpE4iIUoE=;
	b=fVxkX0cKiIlxH2NX78WXSGbmVw5FOIfg+Js6eR5a23yWch2BXpX8YrsCOnPRm4gvbwvQkg
	u5w9AVRHhoYblVShDNzLPBSRA44OXIPRyrDKIa5D92CmG08EmaHsUTty91L6ljUZjH6cXO
	Qugj8IYNuPSaiU9Okj1gHU/FL7TcMOE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-ztt-tIpBN4yKwqKa0Gw-TA-1; Mon,
 27 Jul 2026 16:34:27 -0400
X-MC-Unique: ztt-tIpBN4yKwqKa0Gw-TA-1
X-Mimecast-MFC-AGG-ID: ztt-tIpBN4yKwqKa0Gw-TA_1785184465
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65991195D015;
	Mon, 27 Jul 2026 20:34:25 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DF901956041;
	Mon, 27 Jul 2026 20:34:23 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: i.maximets@ovn.org
Cc: netdev@vger.kernel.org, Eelco Chaudron <echaudro@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [net,1/2] net: openvswitch: fix skb leak on flow key update
 failure during recirculation
In-Reply-To: <20260727181851.306076-2-i.maximets@ovn.org>
References: <20260727181851.306076-1-i.maximets@ovn.org>
 <20260727181851.306076-2-i.maximets@ovn.org>
Date: Mon, 27 Jul 2026 16:34:21 -0400
Message-ID: <f7t5x20xjci.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Ilya Maximets <i.maximets@ovn.org> writes:

> do_execute_actions() returns right away when execute_recirc() fails on
> the last action as it assumes this function always takes ownership of
> the skb when 'last' is true.  But when the flow key update fails, the
> function doesn't free the skb and it ends up leaked.
> 
> This is a very unlikely scenario as it requires the packet to become
> unparseable by applying a set of actions on a previously parseable skb,
> but should be fixed nevertheless.
> 
> Reported by Sashiko.
> 
> Fixes: 971427f353f3 ("openvswitch: Add recirc and hash action.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/openvswitch/actions.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Aaron Conole <aconole@redhat.com>

