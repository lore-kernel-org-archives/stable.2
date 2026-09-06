Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6B20FA81
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701619; cv=none; b=OG7Y/V5MR2fcHtoOWeeqtNP1gAeMbXmWp2AHuaxVWNM3ew++rcUn7JbEdyoiQNBy/sG2mU5YQ0e1Rqhir1a6e2Qn96H9rSmVWjENt+IxfbONxLuHbQSEx2klunmzh4wtctSlixnjc2Ngb5gCkxhcGUtTqJLCx7/ECUaF5eG/aOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701619; c=relaxed/simple;
	bh=vkKe2kDe5Zb9j9+o3Fes4UYqqjcCcz6XxutV10iX1YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+AQeM0arQDtQAlw9Xh0LkOyM/q4yKd+c0G9pD4bPyFknHbzrgdhq7eoyzlOfQ27pD67K10F4oymT9KC6/IPKA7fBMQPjPZZqnYIqXpXh/408/xdu3HHfP15QRz1V35daLK5YrlvRedUWEQacRBYuTkpzmqoDmW5Ixf9CIafuGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBaGNjZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBaGNjZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FBD1F00A3A;
	Sun,  6 Sep 2026 13:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701616;
	bh=H9L4cx84DYMjLixYWCKyoIXzdta7xmulmrSFVcfbkcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lBaGNjZSCdjjKWlsvQVsDO+Pjic6Au2jXR7hQmlkIvRFIk/FJ1T5faPDq9hKfX5vh
	 t8utCvy7pXJ21RsLGZZ+2g37MxqpXf2nLlq/OquT83JEbzXB8Oc8txc/VBEVzffeg6
	 JmBbFBSpXbWDNvrx8/mbm5E/BUw1iC8NS6/PGwvWHfiWTWxopitnfcdoQuOwx4Ahj0
	 zJCBxFrwGP0mxb0YyE8ETKz+SNLTyzgBhO9WvVjNaCqMbalqEBYHcm/WXRdKEMXJAy
	 p7lpNOIwfIuQ6Asye3/iwyVzEZz49eButGeJlI+6fhOu9bcUfaKxu8lj3RztxV6hhH
	 TGiw6LLyPdNmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH 6.12.y 0/2] Backport 'openvswitch: Fix CT limit teardown use-after-free'
Date: Sun,  6 Sep 2026 09:32:42 -0400
Message-ID: <2026-09-05-daily-reply-0012-ovs-ct-limit-uaf-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904092810.1813221-1-i.maximets@ovn.org>
References: <20260904092810.1813221-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The patch doesn't apply well without the previous kernel-doc fix.
> It seems cleaner to backport both instead of modifying the main patch.
>
> Ilya Maximets (1):
>   net: openvswitch: fix kernel-doc warnings in internal headers
>
> Yuqi Xu (1):

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
