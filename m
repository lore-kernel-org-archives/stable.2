Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701551;
	b=gCUdXNH8wcQEAX9nYHmKZpGXVbP9V6ZrRvQAP7jtZNQql3LhbnCFrom1UP4gmJWYdCwK
	 REAJUZQDo8XSkfjj+6T3uI9cfbJ0UtJ2XaOxU6VCIespBb5PjUUhySQ2bbNtbsdneynzg
	 jzEzKe2xL3AlpLi2zCM3HmZiNUJKOa55L79RsbuT3xEL8aIyPjTcv0gcOZsMpK66TyHMa
	 ArUUptzY2S4nF3W20qA44P4omoX1l7w9eEZ8pDl+cul7lZqW5KpkG5cs+9f7u0FHjtpiZ
	 AorlEpP2qUH6E79LYoMYduTBwkCqHNgw0x9Gjqnk9qmIH2oq26FIwTVNIZj/4tvhKMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701551;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZiDCgXI7NCcafNDZdpmexImXqmfoIhQjo1qsG0Dzdno=;
	b=RBomrJL2yOqQBxQjwUwrR6JMqLdxiunURTXwktFZFjT4pXezPVA+QXOGRrs5ea3AMVPj
	 sJx2CnUlUZ98DA/fqOQcvbmH7OjacnjU6w945JMpSm0EMAk3Om/K2lUtKCMAF4tPVBPR4
	 13G+IiOAxTo2OhvhBMEKcjKrRtIhe30VHyFLB8ZLlkgGiSj7CoJgveAtqcuge8oP2Cevu
	 66wfmzZ242tdvBP8JjksAhYhDBMgm7vcTqLf3ZGdOSStb+IxMqg4OazJN7gupPZDGEvOP
	 jMRITfJEBVJCqY5yOuHy3p264dRKabAqcS6oQ/UXznpbdnxwo1879KeXqN81yCcAAdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P2ys5KTF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044F7606BFBE;
	Tue,  3 Nov 2026 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P2ys5KTF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B7C1F00919;
	Tue,  3 Nov 2026 10:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701550;
	bh=ZiDCgXI7NCcafNDZdpmexImXqmfoIhQjo1qsG0Dzdno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P2ys5KTFDKlK2yz+di5tTpouQWufDnbAzeDL0y73Y8bo6Vq/QZlfXVuupyaysdggh
	 4NayCQ7NJSPvtrGE04mH2FlToF+upZ6TKd0EYS4gPYHNeEcks0CnlApEVMxsul4Rbg
	 MyBoPta3v3IxvYCLUszqczCpOkDqkLjuGVoXY0smnWu+KUuus377BrZJSSYQWLVRfI
	 nogofXJZsSsdRPuy8tdiDjE7AK1b4slU4ScVK36NghcZ2kTbrfcr8hO7SKkz+NpkD+
	 YQ2cWGlUXcxM96zNAbTnkw+6eAXNyr2hW2vq9Lw0pblA49db0ND0CCHAEZa/AXzP2g
	 APRHTINuxC2mA==
Date: Tue, 3 Nov 2026 11:25:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Woojung Huh <woojung.huh@microchip.com>, 
	Vladimir Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH] net: dsa: microchip: drop the parent MDIO bus reference
Message-ID: <20261103-fierce-handsome-bullfinch-df2e70@quoll>
References: <20261103100531.1309946-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100531.1309946-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:31 +0000, Wentao Liang wrote:
> ksz_mdio_register() obtains the parent MDIO bus with of_mdio_find_bus(),
> which takes a reference on the embedded struct device, and stores it in
> dev->parent_mdio_bus for the side MDIO accessors.  Nothing ever drops
> that reference, so it is leaked on the probe error paths and when the
> switch device is torn down.
> 
> Register a devres action to put the device when the DSA switch device
> is released.  The child MDIO bus is unregistered before the action
> runs, so the parent bus stays valid for the whole lifetime of the
> switch.
> 
> Fixes: 9afaf0eec2ab ("net: dsa: microchip: Refactor MDIO handling for side MDIO access")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




