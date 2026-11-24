Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536529;
	b=l669mc5iIPCahitrrG0lNrul7587q79wOp8ZY/arlQ13trXwIoxyWRNCRLVFjFTEsWs+
	 yauU+ytJtW1ucp85r5dqACMm0zZgPku5QxzDE+4E4uEx1xrBMgPbo4gtZCBdROt4qQwXn
	 iBqj/KJVNbvZ140AjSWhAuV1dYcdnn58mC7ydK7zq1Lu+p7J3iQ8pQON/MzyqUXbZ0sFy
	 oR0k2b1OrePU/s9JLgY3o4iK4TBjEotqbuaIq6hAStj/kNb21znGjW7mDs1dGnRRBoAFD
	 abVQNk6pPfoJYenn7AzS4TjzyQ5V/qX3rMIl+QWG2nh9v4w0l+lljgaFXunGo9La1SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536529;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cu4DJnNZsLs5NIs795qqZd84WQAmpU5gL5jXFPBDZnw=;
	b=PbBNUWIrJ2nUSh3p+AB5O3GeacSZTIcmiSQeQE8ozbLe1L7u6ODfz8rzOA44MTF8/ZTU
	 dMp5RRfXKDlGerEzvoLrD+1LGQG0dHk4fjeK/25sVs4xw1GDiEcOdIHUTVpLiqrYdVf9Z
	 O2Y4qMsb51V7aSpyoVxnioGRVpJaCsnQP7L6Yww06Wws+juS/samFwYwJLHzqKFDyjxq5
	 RyW60KdNzN2YX7730JtACNc8XhwtfPnZmfDAmzn3GpwMeLEtQBvdXVKEyK6a9VWmTcwBb
	 RKAjeL6xz7uen8BLJ65OUxQGOeqBVb4/3+ZWCiFUyi2j3f1+Rwm4jjc6VR42x9ifUcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldiniIfo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D61E2606A331
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldiniIfo
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BD7631F000C4;
	Tue, 24 Nov 2026 16:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536529;
	bh=cu4DJnNZsLs5NIs795qqZd84WQAmpU5gL5jXFPBDZnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ldiniIfo7RNVej7dUBbaspTGZsiCsLADIbSgszKwN6B1qY3E+T1JlmZvphDqU5jgY
	 VvF1mWnt6j5BZ8cgEss+h7r04ZeL+aCLK8HpsBkdgoD5mUU9FNWEbwLz7szD4a1QuL
	 mi4UKpEIfZyNOM+ef9hJfwAlOPjRudisMK7er/DEZJDQh/v07R0QRlti9hunfWUPH0
	 Ivt4dOt7JYl2osXuvIyycEOXpWUPyNUKRCgNjZv2ePmEyyxTmIXfNq+FDYGSHXoW1E
	 N/p8VqK5Ly33AqLIohw353Rqil8ZzRluCz34Me4gRyhb5nxdkrcEaQmamfgGsUOItj
	 tCDh55RSFhYyQ==
Date: Tue, 24 Nov 2026 18:08:45 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6.18.y] KEYS: Expand key->{datalen,quotalen} to unsigned
 int
Message-ID: <awW2jdOWwVjm5d8C@kernel.org>
References: <2026112410-magenta-immerse-769f@gregkh>
 <20261124160309.4193923-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124160309.4193923-1-sashal@kernel.org>

On Tue, Nov 24, 2026 at 11:03:32AM -0500, Sasha Levin wrote:
> From: Jarkko Sakkinen <jarkko@kernel.org>
> 
> [ Upstream commit 4a65eaf146f0d10ebaa88cfaef9c3b24f93766d9 ]
> 
> In key_alloc() and key_payload_reserve(), key->quotalen and key->datalen
> can receive values larger than USHRT_MAX.
> 
> Example:
> 
>   keyctl new_session >/dev/null
>   owner=$(keyctl newring owner @s)
>   keeper=$(keyctl newring keeper @s)
> 
>   for ((i=0; i<16384; i++)); do
>       key=$(keyctl add user "k$i" x "$keeper")
>       keyctl link "$key" "$owner"
>   done
> 
>   awk -v uid="$(id -u):" '$1 == uid {print $NF}' /proc/key-users
>   keyctl clear "$owner"
>   awk -v uid="$(id -u):" '$1 == uid {print $NF}' /proc/key-users
> 
> Because key->datalen wraps around 65535, the quota refunded upon clearing
> is truncated, causing quota bytes to leak in /proc/key-users.
> 
> Change the types of key->datalen and key->quotalen from unsigned short to
> unsigned int so that they can carry the full payload length without
> truncation.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Link: https://lore.kernel.org/r/20261020174325.2229448-2-jarkko@kernel.org
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> [ sashal: Dropped the context lines using the smb_EIO1/smb_EIO2 helpers, which don't exist here, keeping plain -EIO, and applied only the %hu to %u change in the cifs_dbg strings. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/smb/client/cifsacl.c | 6 +++---
>  include/linux/key.h     | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
> index bb4a258b2c17d..fae9ea3b02d87 100644
> --- a/fs/smb/client/cifsacl.c
> +++ b/fs/smb/client/cifsacl.c
> @@ -319,7 +319,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
>  		goto out_revert_creds;
>  	} else if (sidkey->datalen < CIFS_SID_BASE_SIZE) {
>  		rc = -EIO;
> -		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%hu)\n",
> +		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%u)\n",
>  			 __func__, sidkey->datalen);
>  		goto invalidate_key;
>  	}
> @@ -336,7 +336,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
>  	ksid_size = CIFS_SID_BASE_SIZE + (ksid->num_subauth * sizeof(__le32));
>  	if (ksid_size > sidkey->datalen) {
>  		rc = -EIO;
> -		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%hu, ksid_size=%u)\n",
> +		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%u, ksid_size=%u)\n",
>  			 __func__, sidkey->datalen, ksid_size);
>  		goto invalidate_key;
>  	}
> @@ -430,7 +430,7 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
>  	 */
>  	BUILD_BUG_ON(sizeof(uid_t) != sizeof(gid_t));
>  	if (sidkey->datalen != sizeof(uid_t)) {
> -		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%hu)\n",
> +		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%u)\n",
>  			 __func__, sidkey->datalen);
>  		key_invalidate(sidkey);
>  		goto out_key_put;
> diff --git a/include/linux/key.h b/include/linux/key.h
> index e40b5267658fb..26139c3adf62d 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -216,8 +216,8 @@ struct key {
>  	kuid_t			uid;
>  	kgid_t			gid;
>  	key_perm_t		perm;		/* access permissions */
> -	unsigned short		quotalen;	/* length added to quota */
> -	unsigned short		datalen;	/* payload data length
> +	unsigned int		quotalen;	/* length added to quota */
> +	unsigned int		datalen;	/* payload data length
>  						 * - may not match RCU dereferenced payload
>  						 * - payload should contain own length
>  						 */
> -- 
> 2.53.0
> 

OK, cool :-)  Thanks.

Br, Jarkko
