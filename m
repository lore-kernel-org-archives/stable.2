Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000054;
	b=xyTfjakDTDoUDEQj5EveKoCRwCY/coyhDderdzlCSCyK0s1Q3l4L4IDkO39gD+OXMeFv
	 l9F2jKIkOYWgo7s6QzSeuTlzHAkk9daRsFKuB1wSDxa+sMb9xWnsqn2Pj0WDB0LAQTd7O
	 z0F2GgCaqKw7+HlOvznRB+w1sy+gmol7MmvZ2R8F0meDxqxS5zVc8dvRW7oy16ayEZeSd
	 55F+s0ic1o9FChOO+3MGZZQNfCsEsyYctH+qxrzqZbvOf5HzouNkrGWwRWwBu+bDY0hzO
	 EZgXW2MNfixUT71x1UfUUZFiHeWgG5vJQMAYDqKv59XfnH1a/qKalEd72QZWg0nOnQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000054;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JVMVY/ibZIvadOdefxGxZ8PmbMQ0+x6BAIwaK8SsUkY=;
	b=nef9dqYJT1L9wS33TRY4prRt4WN+cJeQbOfzH4NuITzyUEwACrIuPJmzZ9acer1eMZDj
	 6PcRTbC4b8SyEwag3FrskjHXt+dLEIqK6mYzW2cndhC36H4lTn3SBDnIwlbpeIl8egJRE
	 zA8OIV90W4cgVMH2rO1FMRrHknmnIx5W6ktbjtojK1CwxTRx5JHVyL8xPAhxfw/jgFHdW
	 cpU12hchan+kHttz5kfoVzUg5vw5NNOAOD6c4lc2hCh654Y4ggcoUGUNomXEknBY9squ5
	 WqNPbWXNl4RJNteIoBByv+NMtu/Kp+2+mjhve7DVQjOOGn3VUFir2ZcgFJgQV1BbOQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VB6I5k93;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C265606A326;
	Fri,  6 Nov 2026 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VB6I5k93
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3DC1F0089F;
	Fri,  6 Nov 2026 21:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794000053;
	bh=JVMVY/ibZIvadOdefxGxZ8PmbMQ0+x6BAIwaK8SsUkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VB6I5k939EGIL023j8wwGgNiUdPLQEXY5JEyNYMbEDeS27n4vMHCgnW5XpbxG+g16
	 sovg0g8F/fXGsaAyUE+V0dK6467prrq6cRonE8xcF+MGbcu8ECP3XwHKrzyd6c6gp6
	 gyXG824qAgHa8MamDVOr3YVVNMkNTMHyIlyS3BdP41BYFJrXqiCliO9tqz3CAHigTj
	 ST/kiqocRAHrxO03wzczeasRxMWRHsiOjAjJYct03z6+pLRZQNoRUVQ3Lshq5AwhYT
	 UVLNUeD2OOTKJQi8ICkIpxQu6cfKDCbL4WepLkxq7B9q2PLRYsAJ6wJdER2ElD0Mh/
	 SQ5Ah1s5SirCQ==
Date: Fri, 6 Nov 2026 13:20:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, hramamurthy@google.com, jacob.e.keller@intel.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net v7] net: libwx: fix VF PM suspend/resume flow
Message-ID: <20261106132052.1c719cad@kernel.org>
In-Reply-To: <20261029104220.77344-1-mengyuanlou@net-swift.com>
References: <20261029104220.77344-1-mengyuanlou@net-swift.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 18:42:20 +0800 Mengyuan Lou wrote:
> +open_failed:
> +hard_failure:

The labels should be named after what they do, not the source.
Please read the coding style guide.

> +	/* Do not retry interrupt setup or reopen from the service task. Keep the
> +	 * netdev detached and down, and disable PCI.
> +	 * Retry by rebinding the driver or through a later PM resume; bring the
> +	 * interface up after recovery.
> +	 */
> +	timer_delete_sync(&wx->service_timer);
-- 
pw-bot: cr
