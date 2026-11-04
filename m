Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804622;
	b=llzc9DoQmhDw2LmTAoDRhZDVkXbFi7G54h0MeVAHo6xONETY/rTixPMz2P0YkTUbj6oK
	 roCZceD2IhYDJFVg7C1w/iEmQRwl/WtgwSpvEJLQRWkdfJCoU9rwoCmqp+jsowDBRY/aD
	 PS2d7E6e9lLSV1ZsGsjIX1+BzVjV7KjIGIo0Fv0NWrpj1TNs6r7SgEFqf622PeIWD6p2o
	 PMexhUl1kiwVfv4mELFoux+1QrhybLFrLLnlsWw/t8c4NMuaoBaQUL/vtxyT+lSg61Ms2
	 hvde6SXZRxIBcq4d2VesrhIAfxVkBr9lt5cyVGL6B4MUY2TiiZ47gP7u/SSyFRMVTEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804622;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L6IX47adKfAAcmjbVAEQOyWkXny2KwwUVXNoTOyPbpM=;
	b=cO7gYSCsa693Bbd6qfqbUQvtVM8kH9lAAug/x2gBKLE12UA1uRYNHfnqUdWj9vvqIK9D
	 aVtoMfmt8KUxCdp0TCs84WE/h7lhy7iiX8OTOhpSTwneq6zeeOUdd3JXA29ThDTFIsJw7
	 mhcrsZPiY1tI2ZVpGEJ1SMxIuAmVyNzVesryk8slRWbcpNSUpgv9N0zliwg0LrlX1q8jL
	 t/u6UQ8hrHJXk8GOHcYjcJpS18P22hMuefmb1sPQb2ddmWtN78XPkKa2VJqsP7SVYqG1T
	 DPPFrMFDa+uSyB6QHu8yPOMbQWy5WzDnDMdfXD50JVIsrYl1UO8E2BSUNJ7dklBo1Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZeNAiwcG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17391606EE9C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZeNAiwcG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA0C1F00A16;
	Wed,  4 Nov 2026 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804621;
	bh=L6IX47adKfAAcmjbVAEQOyWkXny2KwwUVXNoTOyPbpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZeNAiwcGjtfvap6gtG8xtjIShQbBu4tB0zUbNzk17ttR/fb7wsZHstgxiCD/hBv4Y
	 kRhfKWMgMAKM7RvX5UopYC0mTw7knxpgOnVKZmgQ7F24rWeSqvfE2Mza0zkfzevw8o
	 wlw7Wf95txJeOsOtmcpGclWzVX0qXFcBKP33IxUsTqNUQrFx3dsuT2wtNfPY4oP+OM
	 V38JaoP51vJ8Ez48wxEmrn8wKhUWdjdkOrWyP698URlUeHVOsH0Cjn6NcXnD1PqlfU
	 xsuU1dDZbLF67DjY9WoeSKzdGKCrx1v3gi0Y7n7y+Zqhpx9zqAeMzCEMMZH8LbjiBy
	 3EtC+Ey+8fg6g==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] ufs: fix ufs_read_cylinder() failure handling
Date: Wed,  4 Nov 2026 10:03:22 -0500
Message-ID: <2026-11-04-1-daily-reply-0013-re-ufs-read-cylinder@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104070538.266761-1-viro@zeniv.linux.org.uk>
References: <20261104070538.266761-1-viro@zeniv.linux.org.uk>
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

On 2026-11-04, Al Viro <viro@zeniv.linux.org.uk> wrote:
> commit 0bfd3e1078c537cd66a8addb1c01835de4234a4c upstream.

Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
