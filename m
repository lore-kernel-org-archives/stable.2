Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868220;
	b=N133EYYz7Q7Kl8uMVKmj64GXvEhEsofvAHpPvAfyoNOISk7GP+Ip3O8/NquFUwmK4MbZ
	 FtjBZTWGpLj3raP/A3uahsnrws3wB+Vgy00omDkQ6ElVviC1cXaTC6XOEf3qzvYOMq2HD
	 stum84Apcs/5TRfRvGYbqurbQtgT9zJb6fKlakKohnERfFju4DHtqfLD68HfN+5AA3mVD
	 W7IcEVxolc+xARN4EDZBfkoFuk3td4qkDdOfa6da04hGlyT4ifs7R6Ul2rF2Q/2w6PYXg
	 n/MFA0+XDs7hpx/VW9H19Nm8x4CiaiLLm98uWjO3/TSPU+mKegwUFMuYJZTCzdJIpnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868220;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xWnyYpFT7Bt2vRXs3GHe7hfE5MPlPmLDrw7MPpPpCg0=;
	b=o3BznYqwp3ruVjgbt6Pqm1eHD1ULzaNAc1k4tZzQUJuwhX/rxpUL6RlHZ66ixhsjlhBu
	 hhsLOXpwLLPNrUrrbhSFMiMHYmBJNNxkxHYWDCupUa9Km/fqFhv4+mZbBiJmJV/ITIg54
	 C0iPVpCVJIp3mv6bvkXdlzYNm4WpHcpPffJ918BUGi190AnEekJTVbGJuS71TgR7LnzI1
	 gPyuepCSvhTKSRafXsouiys6iaPZ3h6UBwqLfeUy2+LM38eKnwIlASaI0yf7Kt3kkVwJi
	 +KMQRcOydozMPrWHqeWrwdSCJYmR7rf6//fbB/TdwcaNUYuZwUIEzNVFz88++nZE9yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c78s14ly;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D35606A31B;
	Thu,  5 Nov 2026 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c78s14ly
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020201F000C1;
	Thu,  5 Nov 2026 08:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793868219;
	bh=xWnyYpFT7Bt2vRXs3GHe7hfE5MPlPmLDrw7MPpPpCg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c78s14lyh/2KA/ZR+ROW9j+lhtL9TK/sW/DGZGAOW3EkLU/0MoWHjI54jQZ0SqEq1
	 YshYj72q4DFMVZv/Lwfu03FDjwgZ3wL9S7VRFiQUVrzrInCgoYg1JfAIJiiyNAORpg
	 4IZ5/JOWtM0cVQPxkLrsv2jTTJfb8zce0lWnAk7ix6e6IHiu0iT5L8XefOM2O9I+wI
	 m7riPX4x+vCLquJlFZzgwzC8W0BUdrdgGovF2Y0pFIf9z7dqCgShdQIMPuSqpWNJnp
	 jV95L/L/vPR7Q9YQbtS8YfwqARC1KLSroRc0BrQJMh4mPy/JGx+8h1w0DmLlfN9Ayj
	 dH2nMJZzp+1gQ==
Date: Thu, 5 Nov 2026 09:43:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Joel Granados <joel.granados@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2 44/51] proc: sysctl: resume readdir after the
 last name it returned
Message-ID: <20261105-unteilbar-entnommen-urzeiten-0d501a3aa396@brauner>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-44-021c84d852e0@kernel.org>
 <CAG48ez3=6q6hqMcN-=q6qNrghHjbpXr+i-Su_s0siw25reBkWA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez3=6q6hqMcN-=q6qNrghHjbpXr+i-Su_s0siw25reBkWA@mail.gmail.com>

On Thu, 5 Nov 2026 01:08:36 +0100, Jann Horn wrote:
> sysctl_cursor_set() is called here, when the output buffer is too
> small; but not if the proc_sys_readdir() loop ends because the end of
> the table was reached and "h" is NULL?

It's the other way around. res is true when the entry went into the
buffer. The cursor moves with every entry that was emitted. That
includes the last entry of the table.

When the buffer is full, res is false, we stop, and the cursor leads us
to the last entry that we sent.

> Doesn't that mean that another getdents() after reaching end of the
> file would observe the last entries again?

No. After the last entry, cursor->pos == ctx->pos. So the next getdents
does entry_after(last_name). That doens't find anything. So h is NULL,
the loop doesn't run and it returns zero.

If an entry registered behind the name it would show up.
