Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702087;
	b=eQvAkwnPFDvFM8QD0sFoJHvFbSd5gIL6SsNESCPJQMAUMv6Pvm1oWMlX15yUj+04vTCL
	 KUfDDPxm28/IG4xT4uUExS1HiPomKpz3Byugh+AUsr+7JDK1LTBC9ODLbjPckFQDzzjvb
	 s2PYrvOThOaiakjkvR9DdVsNJIsaI4dMFLuY8P8s3dcjWPtHoCKmQ95S/q37PesZ7J8tw
	 URjRfwcePQhCL6/ZjRl01y/H5mQ2u9U1LbcSpQq9iO7cSSPZE3xFHXSHunXh7esJCyjnW
	 ccKk7arZ+z/H/j2wFEh1F9kwqKe5wGYCyjj2p+hSXsrqH9bPIwohzY4q0eA1f/3XqCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702087;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=qK8GZaDVBN29brKJEtio0yCkoyqX1u2lUG9bEbtTMDodQyLfC43dtb6ysv/Lp3/dZ7Oc
	 bp7YD/mNkPR62N+QED48hcOQi6M0S7mmzvj5pn1R2OWX5GOVFXH+I9i8+FN4GaYX9F5W2
	 aVBZkT4EEiz9JVYW/+fgBxql2obXEbsPMhOJOvfpZU9ya50gazOPhSS8vbZDmtIRqyIip
	 NYPGxcZLdItjmEunsVDQ74upo2gi8MbVDNDj4V7QymiY9H4XuGTD6ctybsrGjh2TBWnuz
	 yv8Ct2R7QS9MP8XCtp7gj1K4+mSmqvExdlQw/XsDTqQLNaTjnYIcgtnsk7vGWvtoxNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhvtAJHZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E460736C0;
	Tue,  3 Nov 2026 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhvtAJHZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261111F00919;
	Tue,  3 Nov 2026 10:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702086;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BhvtAJHZeYQIMg97ZMZ/UsiRQ/bfdXmMDtCZNSyzlKIAt2+2fc8GsEdEhW/yJB8Pe
	 li5XTil64wZr/Eppw2rPf/vvg4EPGqFpg7yxRu6rNLggmbKWWclCXqMN/LBNAbMf6e
	 657PgJfORhVLFmM9w4EMUr/oEn641LakT49XalDvCBUAmkTXD77sPU/dheQ91sygG0
	 KIui+33YoCt7Co0GnGrRRr1E+UnaNdRdUbxO5U5QCzwi2k7kd+CliqZ6qMPrvFh2rs
	 lvvYVtYEbu0uZtowLCWZYXwUJC0XC0g4z32Lbl94yKZaNI0oeakua7lGrOzbqsCJdg
	 U1IbtCZ3/wceg==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: lan969x: fix page pool leak when RX DMA allocation fails
Date: Tue, 03 Nov 2026 10:34:45 +0000
Message-ID: <179370208572.488859.13061346366607399328@kernel.org>
In-Reply-To: <20261103102854.1340615-1-vulab@iscas.ac.cn>
References: <20261103102854.1340615-1-vulab@iscas.ac.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
